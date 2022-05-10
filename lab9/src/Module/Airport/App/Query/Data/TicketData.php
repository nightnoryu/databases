<?php
declare(strict_types=1);

namespace App\Module\Airport\App\Query\Data;

use DateTimeImmutable;
use JsonSerializable;

class TicketData implements JsonSerializable
{
    private int $id;
    private string $class;
    private float $priceMultiplier;
    private DateTimeImmutable $purchaseDate;

    private int $flightId;

    public function __construct(
        int $id,
        string $class,
        float $priceMultiplier,
        DateTimeImmutable $purchaseDate,
        int $flightId
    ) {
        $this->id = $id;
        $this->class = $class;
        $this->priceMultiplier = $priceMultiplier;
        $this->purchaseDate = $purchaseDate;
        $this->flightId = $flightId;
    }

    public function getId(): int
    {
        return $this->id;
    }

    public function getClass(): string
    {
        return $this->class;
    }

    public function getPriceMultiplier(): float
    {
        return $this->priceMultiplier;
    }

    public function getPurchaseDate(): DateTimeImmutable
    {
        return $this->purchaseDate;
    }

    public function getFlightId(): int
    {
        return $this->flightId;
    }

    public function jsonSerialize(): array
    {
        return ['id' => $this->getId(), 'class' => $this->getClass(), 'price_multiplier' => $this->getPriceMultiplier(), 'purchase_date' => $this->getPurchaseDate(), 'flight_id' => $this->getFlightId(),];
    }
}
