<?php
declare(strict_types=1);

namespace App\Module\Airport\App;

use App\Module\Airport\App\Exception\FlightNotFoundException;
use App\Module\Airport\App\Exception\PassengerNotFoundException;
use App\Module\Airport\App\Exception\TicketNotFoundException;
use DateTimeImmutable;

interface AirportServiceInterface
{
    public function addFlight(
        DateTimeImmutable $startDate,
        DateTimeImmutable $endDate,
        int $seatsAmount,
        float $price
    ): void;

    public function addPassenger(string $firstName, string $lastName, bool $gender, DateTimeImmutable $birthDate): void;

    /**
     * @throws FlightNotFoundException
     * @throws PassengerNotFoundException
     */
    public function addTicket(
        int $flightId,
        int $passengerId,
        string $class,
        float $priceMultiplier,
        DateTimeImmutable $purchaseDate
    ): void;

    /**
     * @throws TicketNotFoundException
     */
    public function updateTicket(
        int $ticketId,
        ?string $class,
        ?float $priceMultiplier,
        ?DateTimeImmutable $purchaseDate
    ): void;

    /**
     * @throws TicketNotFoundException
     */
    public function removeTicket(int $ticketId): void;
}
