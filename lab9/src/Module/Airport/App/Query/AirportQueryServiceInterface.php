<?php
declare(strict_types=1);

namespace App\Module\Airport\App\Query;

use App\Module\Airport\App\Query\Data\TicketData;

interface AirportQueryServiceInterface
{
    /**
     * @return TicketData[]
     */
    public function findTicketsByPassengerName(string $name): array;

    public function getAmountOfTicketsForFlight(int $flightId): int;
}
