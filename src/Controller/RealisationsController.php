<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\RealisationRepository;

class RealisationsController extends AbstractController
{
    #[Route('/realisations', name: 'realisations')]
    public function index(RealisationRepository $realisationRepository): Response
    {
        $realisations = $realisationRepository->findAll();
        



        return $this->render('realisations/index.html.twig', [
            'realisations' => $realisations,
        ]);
    }
}

