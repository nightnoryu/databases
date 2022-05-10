<?php
declare(strict_types=1);

namespace App\Module\Airport\Domain;

use DateTimeImmutable;

class Ticket
{
    private int $id;
    private string $class;
    private float $priceMultiplier;
    private DateTimeImmutable $purchaseDate;

    private Flight $flight;
    private Passenger $passenger;

    public function __construct(
        string $class,
        float $priceMultiplier,
        DateTimeImmutable $purchaseDate,
        Flight $flight,
        Passenger $passenger
    ) {
        $this->class = $class;
        $this->priceMultiplier = $priceMultiplier;
        $this->purchaseDate = $purchaseDate;

        $this->flight = $flight;
        $this->passenger = $passenger;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getClass(): string
    {
        return $this->class;
    }

    public function setClass(string $class): void
    {
        $this->class = $class;
    }

    public function getPriceMultiplier(): float
    {
        return $this->priceMultiplier;
    }

    public function setPriceMultiplier(float $priceMultiplier): void
    {
        $this->priceMultiplier = $priceMultiplier;
    }

    public function getPurchaseDate(): DateTimeImmutable
    {
        return $this->purchaseDate;
    }

    public function setPurchaseDate(DateTimeImmutable $purchaseDate): void
    {
        $this->purchaseDate = $purchaseDate;
    }

    public function getFlight(): Flight
    {
        return $this->flight;
    }

    public function setFlight(Flight $flight): void
    {
        $this->flight = $flight;
    }

    public function getPassenger(): Passenger
    {
        return $this->passenger;
    }

    public function setPassenger(Passenger $passenger): void
    {
        $this->passenger = $passenger;
    }
}
