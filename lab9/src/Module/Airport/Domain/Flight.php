<?php
declare(strict_types=1);

namespace App\Module\Airport\Domain;

use DateTimeImmutable;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;

class Flight
{
    private int $id;
    private DateTimeImmutable $startDate;
    private DateTimeImmutable $endDate;
    private int $seatsAmount;
    private float $price;

    private Collection $tickets;

    public function __construct(
        DateTimeImmutable $startDate,
        DateTimeImmutable $endDate,
        int $seatsAmount,
        float $price
    ) {
        $this->startDate = $startDate;
        $this->endDate = $endDate;
        $this->seatsAmount = $seatsAmount;
        $this->price = $price;

        $this->tickets = new ArrayCollection();
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getStartDate(): DateTimeImmutable
    {
        return $this->startDate;
    }

    public function setStartDate(DateTimeImmutable $startDate): void
    {
        $this->startDate = $startDate;
    }

    public function getEndDate(): DateTimeImmutable
    {
        return $this->endDate;
    }

    public function setEndDate(DateTimeImmutable $endDate): void
    {
        $this->endDate = $endDate;
    }

    public function getSeatsAmount(): int
    {
        return $this->seatsAmount;
    }

    public function setSeatsAmount(int $seatsAmount): void
    {
        $this->seatsAmount = $seatsAmount;
    }

    public function getPrice(): float
    {
        return $this->price;
    }

    public function setPrice(float $price): void
    {
        $this->price = $price;
    }

    /**
     * @return Collection|Ticket[]
     */
    public function getTickets(): Collection
    {
        return $this->tickets;
    }

    public function addTicket(Ticket $ticket): void
    {
        $this->tickets->add($ticket);
    }

    public function removeTicket(Ticket $ticket): void
    {
        $this->tickets->removeElement($ticket);
    }
}
