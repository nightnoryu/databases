<?php
declare(strict_types=1);

namespace App\Controller\Airport;

use App\Module\Airport\App\AirportServiceInterface;
use App\Module\Airport\App\Query\AirportQueryServiceInterface;
use DateTimeImmutable;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;

class AirportController extends AbstractController
{
    private AirportServiceInterface $airportService;
    private AirportQueryServiceInterface $airportQueryService;

    public function __construct(
        AirportServiceInterface $airportService,
        AirportQueryServiceInterface $airportQueryService
    ) {
        $this->airportService = $airportService;
        $this->airportQueryService = $airportQueryService;
    }

    /**
     * @OA\Post(
     *     path="/airport/api/flight",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="start_date",
     *                 type="string",
     *                 format="date"
     *             ),
     *             @OA\Property(
     *                 property="end_date",
     *                 type="string",
     *                 format="date"
     *             ),
     *             @OA\Property(
     *                 property="seats_amount",
     *                 type="int"
     *             ),
     *             @OA\Property(
     *                 property="price",
     *                 type="double"
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response="200",
     *         description="Success response"
     *     )
     * )
     */
    public function addFlight(Request $request): Response
    {
        $parameters = json_decode($request->getContent(), true);
        $startDate = new DateTimeImmutable($parameters['start_date']);
        $endDate = new DateTimeImmutable($parameters['end_date']);

        $this->airportService->addFlight($startDate, $endDate, $parameters['seats_amount'], $parameters['price']);

        return new Response();
    }

    /**
     * @OA\Post(
     *     path="/airport/api/passenger",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="first_name",
     *                 type="string"
     *             ),
     *             @OA\Property(
     *                 property="last_name",
     *                 type="string"
     *             ),
     *             @OA\Property(
     *                 property="gender",
     *                 type="boolean"
     *             ),
     *             @OA\Property(
     *                 property="birth_date",
     *                 type="string",
     *                 format="date"
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response="200",
     *         description="Success response"
     *     )
     * )
     */
    public function addPassenger(Request $request): Response
    {
        $parameters = json_decode($request->getContent(), true);
        $birthDate = new DateTimeImmutable($parameters['birth_date']);

        $this->airportService->addPassenger(
            $parameters['first_name'],
            $parameters['last_name'],
            $parameters['gender'],
            $birthDate
        );

        return new Response();
    }

    /**
     * @OA\Post(
     *     path="/airport/api/ticket",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(
     *                 property="flight_id",
     *                 type="int"
     *             ),
     *             @OA\Property(
     *                 property="passenger_id",
     *                 type="int"
     *             ),
     *             @OA\Property(
     *                 property="class",
     *                 type="string"
     *             ),
     *             @OA\Property(
     *                 property="priceMultiplier",
     *                 type="double"
     *             ),
     *             @OA\Property(
     *                 property="purchase_date",
     *                 type="string",
     *                 format="date"
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response="200",
     *         description="Success response"
     *     )
     * )
     */
    public function addTicket(Request $request): Response
    {
        $parameters = json_decode($request->getContent(), true);
        $purchaseDate = new DateTimeImmutable($parameters['purchase_date']);

        $this->airportService->addTicket(
            $parameters['flight_id'],
            $parameters['passenger_id'],
            $parameters['class'],
            $parameters['priceMultiplier'],
            $purchaseDate
        );

        return new Response();
    }

    public function findTicketsByPassengerName(Request $request): Response
    {
        $tickets = $this->airportQueryService->findTicketsByPassengerName($request->get('name'));

        return new Response(json_encode($tickets, JSON_THROW_ON_ERROR));
    }
}
