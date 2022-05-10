<?php
declare(strict_types=1);

namespace App\Module\Airport\Infrastructure;

use App\Module\Airport\App\Query\AirportQueryServiceInterface;
use App\Module\Airport\App\Query\Data\TicketData;
use App\Module\Airport\Domain\Ticket;
use Doctrine\ORM\EntityManagerInterface;

class AirportQueryService implements AirportQueryServiceInterface
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    public function findTicketsByPassengerName(string $name): array
    {
        $qb = $this->entityManager->createQueryBuilder()->select('t')->from(Ticket::class, 't')->innerJoin(
            't.passenger',
            'p'
        )->where('CONCAT(p.firstName, \' \', p.lastName) LIKE :name')->setParameter('name', "%$name%");

        /** @var Ticket[] $tickets */
        $tickets = $qb->getQuery()->execute();

        $result = [];
        foreach ($tickets as $ticket)
        {
            $result[] = new TicketData(
                $ticket->getId(),
                $ticket->getClass(),
                $ticket->getPriceMultiplier(),
                $ticket->getPurchaseDate(),
                $ticket->getPassenger()->getId()
            );
        }

        return $result;
    }
}
