<?php



namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;

class SitemapController extends AbstractController
{
    #[Route('/sitemap', name: 'sitemap', defaults: ['_format' => 'xml'])]
    public function index(UrlGeneratorInterface $urlGenerator): Response
    {
        $urls = [
            $urlGenerator->generate('homepage', [], UrlGeneratorInterface::ABSOLUTE_URL),
            $urlGenerator->generate('services', [], UrlGeneratorInterface::ABSOLUTE_URL),
            $urlGenerator->generate('contact', [], UrlGeneratorInterface::ABSOLUTE_URL),
            $urlGenerator->generate('realisations', [], UrlGeneratorInterface::ABSOLUTE_URL),
            $urlGenerator->generate('mention', [], UrlGeneratorInterface::ABSOLUTE_URL),
        ];

        $xml = new \SimpleXMLElement('<?xml version="1.0" encoding="UTF-8"?><urlset/>');
        $xml->addAttribute('xmlns', 'http://www.sitemaps.org/schemas/sitemap/0.9');

        foreach ($urls as $url) {
            $entry = $xml->addChild('url');
            $entry->addChild('loc', $url);
            $entry->addChild('changefreq', 'monthly');
            $entry->addChild('priority', '0.8');
        }

        return new Response($xml->asXML(), 200, [
            'Content-Type' => 'application/xml'
        ]);
    }
}
