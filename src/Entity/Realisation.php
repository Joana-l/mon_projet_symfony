<?php

namespace App\Entity;

use App\Repository\RealisationRepository;
use Doctrine\DBAL\Types\Types;
use Symfony\Component\HttpFoundation\File\File;
use Vich\UploaderBundle\Mapping\Annotation as Vich;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: RealisationRepository::class)]
#[Vich\Uploadable]
class Realisation
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $titre = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $description = null;

    #[ORM\Column(length: 255, nullable: true)] // Ajoute nullable: true
    private ?string $image = null;

    #[Vich\UploadableField(mapping: 'realisation_images', fileNameProperty: 'image')]
    private ?File $imageFile = null; // Ce champ ne sera pas stocké en BDD

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]

    private ?\DateTimeInterface $date_current = null;

    #[ORM\ManyToOne(targetEntity: User::class, inversedBy: "realisations")]
    #[ORM\JoinColumn(nullable: false)] 
    private ?User $user = null;

     
    public function getUser(): ?User
    {
        return $this->user;
    }
 
    public function setUser(?User $user): self
    {
        $this->user = $user;
        return $this;
    }




    public function setImageFile(?File $imageFile = null): void
    {
        $this->imageFile = $imageFile;
    }

    public function getImageFile(): ?File
    {
        return $this->imageFile;
    }




    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitre(): ?string
    {
        return $this->titre;
    }

    public function setTitre(string $titre): static
    {
        $this->titre = $titre;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): static
    {
        $this->description = $description;

        return $this;
    }

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): static
    {
        $this->image = $image;

        return $this;
    }

    public function __construct()
    {
        $this->date_current = new \DateTimeImmutable();
    }


    public function getDateCurrent(): ?\DateTimeInterface
    {
        return $this->date_current;
    }

    public function setDateCurrent(\DateTimeInterface $date_current): static
    {
        $this->date_current = $date_current;

        return $this;
    }

    #[ORM\PreUpdate]
    public function updateDate(): void
    {
        $this->date_current = new \DateTimeImmutable();
    }

    #[ORM\PreRemove]
    public function removeImageFile(): void
    {
        if ($this->image) {
            $filePath = __DIR__ . '/../../public/uploads/realisation/' . $this->image;
            if (file_exists($filePath)) {
                unlink($filePath);
            }
            $this->image = null; // Assure que l'image est bien réinitialisée
        }
    }
}
