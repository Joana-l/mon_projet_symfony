<?php

namespace App\Controller;

use App\Form\ContactType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\Routing\Attribute\Route;

class ContactController extends AbstractController {
    #[Route('/contact', name: 'contact')]
    public function index(Request $request, MailerInterface $mailer): Response
    {
        $form = $this->createForm(ContactType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $data = $form->getData();
            $honeypotValue = $form->get('honeypot')->getData();

            // Vérification du honeypot
            if (!empty($honeypotValue)) {
                return $this->redirectToRoute('contact'); 
            }

            // Sécurisation des données
            $address = filter_var($data['email'], FILTER_SANITIZE_EMAIL);
            $content = htmlspecialchars($data['content'], ENT_QUOTES, 'UTF-8');

            //Verification email valide
            if (!filter_var($address, FILTER_VALIDATE_EMAIL)) {
                $this->addFlash('danger', 'Adresse e-mail invalide.');
                return $this->redirectToRoute('contact');
            }

            // Protection contre les spams 
            $session = $request->getSession();
            $lastSubmission = $session->get('last_submission_time', 0);
            $now = time();
            if ($now - $lastSubmission < 30) { 
                $this->addFlash('danger', 'Veuillez patienter avant de renvoyer un message.');
                return $this->redirectToRoute('contact');
            }
            $session->set('last_submission_time', $now);

            // Création et envoi de l'e-mail
            $email = (new Email())
                ->from('noreply@tonsite.com') // Adresse fixe pour éviter le spoofing
                ->replyTo($address) // Permet de répondre au visiteur
                ->to('you@example.com')
                ->subject('Nouvelle demande de contact')
                ->text($content);

            $mailer->send($email);

            $this->addFlash('success', 'Votre message a bien été envoyé.');
            return $this->redirectToRoute('contact');
            
        }

        return $this->render('contact/index.html.twig', [
            'controller_name' => 'ContactController',
            'formulaire' => $form
        ]);
    }
}

