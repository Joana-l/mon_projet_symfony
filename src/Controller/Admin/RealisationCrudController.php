<?php

namespace App\Controller\Admin;

use App\Entity\Realisation;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use Vich\UploaderBundle\Form\Type\VichImageType;
use Symfony\Bundle\SecurityBundle\Security;
use Doctrine\ORM\EntityManagerInterface;

class RealisationCrudController extends AbstractCrudController
{

    public function __construct(private Security $security) {}


    public static function getEntityFqcn(): string
    {
        return Realisation::class;
    }

    
    public function configureFields(string $pageName): iterable
    {
        return [
            IdField::new('id')->hideOnForm(),
            TextField::new('titre'),
            TextEditorField::new('description'),

            
            
            // Champ pour l'upload
            TextField::new('imageFile')
                ->setFormType(VichImageType::class)
                ->onlyOnForms(),
    
            // Affichage de l'image dans la liste
            ImageField::new('image')
                ->setBasePath('/uploads/realisation')
                ->setUploadedFileNamePattern('[slug]-[timestamp].[extension]')
                ->setRequired(false) 
                ->onlyOnIndex(),
                
    
            DateTimeField::new('date_current')->hideOnForm(),
        ];
    }



    public function persistEntity(EntityManagerInterface $entityManager, $entityInstance): void
    {
        // Vérifier que l'entité est bien une réalisation
        if (!$entityInstance instanceof Realisation) {
            return;
        }

        // Associer l'utilisateur connecté
        $entityInstance->setUser($this->security->getUser());

        // Sauvegarder en base
        parent::persistEntity($entityManager, $entityInstance);
    }
    
}
