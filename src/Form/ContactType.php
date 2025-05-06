<?php

namespace App\Form;




use Symfony\Component\Form\Extension\Core\Type\TextType;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;
use Symfony\Component\Form\Extension\Core\Type\CsrfType;
use Symfony\Component\Validator\Constraints as Assert;
use Symfony\Component\Form\Extension\Core\Type\CheckboxType;

class ContactType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, [
                'label' => 'Nom',
                'attr' => ['placeholder' => 'Votre nom'],
                'constraints' => [
                    new Assert\NotBlank(['message' => 'Le nom est obligatoire.']),
                ],
            ])
            ->add('email', EmailType::class, [
                'label' => 'E-mail',
                'attr' => ['placeholder' => 'Votre adresse mail'],
                'constraints' => [
                    new Assert\NotBlank(['message' => 'l\'email est obligatoire']),
                    new Assert\Email(['message' => 'l\'email n\'est pas valide']),
                ],
            ])
            ->add('content', TextareaType::class, [
                'label' => 'Message',
                'attr' => ['placeholder' => 'Décrivez votre demande'],
                'constraints' => [
                    new Assert\NotBlank(['message' => 'le message est obligatoire']),
                    new Assert\Length([
                        'min' => 10,
                        'minMessage' => 'Le message doit contenir au moins {{ limit }} caractères'
                    ]),
                ],
            ])

            ->add('honeypot', HiddenType::class, [
                'mapped' => false,  // Ne pas enregistrer en base de données
                'required' => false, // Ne pas obliger l'utilisateur à le remplir
                'attr' => [
                    'style' => 'display:none', // Caché pour les humains
                    'aria-hidden' => 'true', // Invisible pour les lecteurs d'écran
                ],
            ])

            ->add('rgpd', CheckboxType::class, [
                'label' => 'j\'accepte la <a href="/mention" target="_blank" style="color:#fff; text-decoration : underline">politique deconfidentialié</a>',
                'label_html' => true,
                'mapped' => false,
                'constraints' => [
                    new Assert\IsTrue([
                        'message' => 'Vous devez accepter la politique de confidentiaité.'
                    ]),
                ],

            ])
            

            ->add('envoyer', SubmitType::class, [
                'label' => 'Envoyer'


            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'csrf_protection' => true,
            'csrf_field_name' => '_token',
            'csrf_token_id'   => 'contact_form',
        ]);
    }
}
