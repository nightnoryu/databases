<?php
declare(strict_types=1);

namespace App\Module\Airport\App\Exception;

class FlightNotFoundException extends \Exception
{
    public function __construct(?\Throwable $previous = null)
    {
        parent::__construct('Flight not found', 0, $previous);
    }
}
