<?php
declare(strict_types=1);

namespace App\Module\Airport\Infrastructure;

use App\Module\Airport\App\AirportServiceInterface;
use App\Module\Airport\App\Exception\FlightNotFoundException;
use App\Module\Airport\App\Exception\PassengerNotFoundException;
use App\Module\Airport\App\Exception\TicketNotFoundException;
use App\Module\Airport\Domain\Flight;
use App\Module\Airport\Domain\Passenger;
use App\Module\Airport\Domain\Ticket;
use DateTimeImmutable;
use Doctrine\Persistence\ManagerRegistry;

class AirportService implements AirportServiceInterface
{
    private ManagerRegistry $doctrine;

    public function __construct(ManagerRegistry $doctrine)
    {
        $this->doctrine = $doctrine;
    }

    public function addFlight(
        DateTimeImmutable $startDate,
        DateTimeImmutable $endDate,
        int $seatsAmount,
        float $price
    ): void {
        $flight = new Flight($startDate, $endDate, $seatsAmount, $price);

        $entityManager = $this->doctrine->getManager();
        $entityManager->persist($flight);
        $entityManager->flush();
    }

    public function addPassenger(string $firstName, string $lastName, bool $gender, DateTimeImmutable $birthDate): void
    {
        $passenger = new Passenger($firstName, $lastName, $gender, $birthDate);

        $entityManager = $this->doctrine->getManager();
        $entityManager->persist($passenger);
        $entityManager->flush();
    }

    public function addTicket(
        int $flightId,
        int $passengerId,
        string $class,
        float $priceMultiplier,
        DateTimeImmutable $purchaseDate
    ): void {
        /** @var Flight $flight */
        $flight = $this->doctrine->getRepository(Flight::class)->find($flightId);
        if ($flight === null)
        {
            throw new FlightNotFoundException();
        }

        /** @var Passenger $passenger */
        $passenger = $this->doctrine->getRepository(Passenger::class)->find($passengerId);
        if ($passenger === null)
        {
            throw new PassengerNotFoundException();
        }

        $ticket = new Ticket($class, $priceMultiplier, $purchaseDate, $flight, $passenger);

        $entityManager = $this->doctrine->getManager();
        $entityManager->persist($ticket);
        $entityManager->flush();
    }

    public function updateTicket(
        int $ticketId,
        ?string $class,
        ?float $priceMultiplier,
        ?DateTimeImmutable $purchaseDate
    ): void {
        /** @var Ticket $ticket */
        $ticket = $this->doctrine->getRepository(Ticket::class)->find($ticketId);
        if ($ticket === null)
        {
            throw new TicketNotFoundException();
        }

        if ($class !== null)
        {
            $ticket->setClass($class);
        }
        if ($priceMultiplier !== null)
        {
            $ticket->setPriceMultiplier($priceMultiplier);
        }
        if ($purchaseDate !== null)
        {
            $ticket->setPurchaseDate($purchaseDate);
        }

        $entityManager = $this->doctrine->getManager();
        $entityManager->persist($ticket);
        $entityManager->flush();
    }

    public function removeTicket(int $ticketId): void
    {
        $ticket = $this->doctrine->getRepository(Ticket::class)->find($ticketId);
        if ($ticket === null)
        {
            throw new TicketNotFoundException();
        }

        $entityManager = $this->doctrine->getManager();
        $entityManager->remove($ticket);
        $entityManager->flush();
    }
}
