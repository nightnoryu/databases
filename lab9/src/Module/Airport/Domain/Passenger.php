<?php
declare(strict_types=1);

namespace App\Module\Airport\Domain;

use DateTimeImmutable;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;

class Passenger
{
    private int $id;
    private string $firstName;
    private string $lastName;
    private bool $gender;
    private DateTimeImmutable $birthDate;

    private Collection $tickets;

    public function __construct(string $firstName, string $lastName, bool $gender, DateTimeImmutable $birthDate)
    {
        $this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->gender = $gender;
        $this->birthDate = $birthDate;

        $this->tickets = new ArrayCollection();
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getFirstName(): string
    {
        return $this->firstName;
    }

    public function setFirstName(string $firstName): void
    {
        $this->firstName = $firstName;
    }

    public function getLastName(): string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName): void
    {
        $this->lastName = $lastName;
    }

    public function getGender(): bool
    {
        return $this->gender;
    }

    public function setGender(bool $gender): void
    {
        $this->gender = $gender;
    }

    public function getBirthDate(): DateTimeImmutable
    {
        return $this->birthDate;
    }

    public function setBirthDate(DateTimeImmutable $birthDate): void
    {
        $this->birthDate = $birthDate;
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
