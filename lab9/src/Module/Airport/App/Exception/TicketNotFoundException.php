<?php
declare(strict_types=1);

namespace App\Module\Airport\App\Exception;

class TicketNotFoundException extends \Exception
{
    public function __construct(?\Throwable $previous = null)
    {
        parent::__construct('Ticket not found', 0, $previous);
    }
}
