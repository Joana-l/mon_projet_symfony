<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250517113733 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql("INSERT INTO \"user\" (email, roles, password) VALUES (
            'aleaurulleau33@hotmail.com',
            '[\"ROLE_ADMIN\"]',
            '\$2y\$13\$xjLIrU.sEx3upO3LRXmSC.84oZMbPv0ZDVmDP1Mv.GPkhiyC.9nwG'
        )");

    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql("DELETE FROM \"user\" WHERE email = 'aleaurulleau33@hotmail.com'");

    }
}
