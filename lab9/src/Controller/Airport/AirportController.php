<?php
declare(strict_types=1);

namespace App\Controller\Airport;

use App\Module\Airport\App\AirportServiceInterface;
use OpenApi\Annotations as OA;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class AirportController extends AbstractController
{
    private AirportServiceInterface $airportService;

    public function __construct(AirportServiceInterface $airportService)
    {
        $this->airportService = $airportService;
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
    public function addFlight(): Response
    {
        return new Response('flight');
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
    public function addPassenger(): Response
    {
        return new Response('passenger');
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
    public function addTicket(): Response
    {
        return new Response('ticket');
    }
}
