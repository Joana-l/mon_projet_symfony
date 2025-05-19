<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20250519120000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Ajoute un utilisateur admin';
    }

    public function up(Schema $schema): void
    {
        $this->addSql("INSERT INTO \"user\" (email, roles, password) VALUES (
            'admin@aleaurulleau.fr',
            '[\"ROLE_ADMIN\"]',
            '\$2y\$13\$VtixjrsUpzvYbpRe0wnHaOL1HIs0R7YjRZ6CkI6bsA5zNKKsKn1ju'
        )");
    }

    public function down(Schema $schema): void
    {
        $this->addSql("DELETE FROM \"user\" WHERE email = 'admin@aleaurulleau.fr'");
    }
}
