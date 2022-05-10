<?php
declare(strict_types=1);

namespace App\Module\Airport\Infrastructure;

use App\Module\Airport\App\AirportServiceInterface;
use App\Module\Airport\App\Exception\FlightNotFoundException;
use App\Module\Airport\App\Exception\PassengerNotFoundException;
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
        $flight = $this->doctrine->getRepository(Flight::class)->find($flightId);
        if ($flight === null)
        {
            throw new FlightNotFoundException();
        }

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
}
