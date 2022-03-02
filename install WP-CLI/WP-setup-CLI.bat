@echo off
rem #!/bin/bash

rem -------------------------------------------------------------------
rem  Скрипт автоустановки WP-CLI для CMS WordPress
rem  с предустановленными настройками
rem  Информация актуальна на 03.2022
rem ------------------------------------------------------------------

if (%1)==() goto %noparam
if (%2)==() goto %noparam


php wp core download
rem Параметры указанные заглавными необходимо изменить на свои значения под конкретную установку
rem  ===Создание конфигурации с переменными: WP_DBNAME, NAMEDOMAIN.LOCAL, PASSWORD ===

php wp config create --dbname=%2 --dbuser=DBUSER --dbpass=DBPASS
php wp db create
php wp core install --url=%1 --title="SITE TITLE" --admin_user=ADMIN_USER --admin_password=PASSWORD --admin_email=YOUR@EMAIL.COM


rem  ===Удаление лишних настроек и данных===

php wp plugin delete hello
php wp plugin delete aksimet

php wp comment delete $(wp comment list --format=ids)
php wp post delete $(wp post list --post_type='post' --format=ids)
php wp post delete $(wp post list --post_type='page' --format=ids)
php wp site empty
php wp site empty --uploads

rem  ===Установка и активация плагинов===

rem php wp plugin install getwid
rem php wp plugin activate getwid

rem php wp plugin install advanced-custom-fields
rem php wp plugin activate advanced-custom-fields

rem php wp plugin install acf-extended
rem php wp plugin activate acf-extended

rem php wp plugin install gutentor
rem php wp plugin activate gutentor

php wp plugin install wp-mail-smtp
php wp plugin activate wp-mail-smtp

php wp plugin install wp-fastest-cache
php wp plugin activate wp-fastest-cache

php wp plugin install regenerate-thumbnails
php wp plugin activate regenerate-thumbnails

php wp plugin install wp-file-manager
php wp plugin activate wp-file-manager

php wp plugin install gutenberg
php wp plugin activate gutenberg

rem Yoast SEO
php wp plugin install wordpress-seo
php wp plugin activate wordpress-seo

rem для новых плагинов
rem php wp plugin install 
rem php wp plugin activate 

rem php wp option update fm-lang ru

rem  ===Установка собственных плагинов===

php wp plugin install citotnik
php wp plugin activate citotnik 

rem  ===Установка и активация тем===

rem php wp theme install twentyfifteen
rem php wp theme activate twentyfifteen

rem php wp theme install twentysixteen
rem php wp theme activate twentysixteen

rem php wp theme install twentyseventeen
rem php wp theme activate twentyseventeen

rem php wp theme install twentynineteen
rem php wp theme activate twentynineteen

rem php wp theme install twentytwenty
rem php wp theme activate twentytwenty

php wp theme install twentytwentyone
php wp theme activate twentytwentyone

php wp theme install twentytwentytwo
php wp theme activate twentytwentytwo

rem  ===Настройка config.php===

php wp rewrite structure '/%category%/%post_id%'
rem  php wp option update blog_public 1
php wp option update blogname "Your site name"
php wp option update blogdescription "Your site description"
php wp option update default_comment_status closed
php wp option update default_ping_status closed
php wp option update timezone_string "Europe/Moscow"

rem  ===Создание пользователей по умолчанию===

rem php wp user create john john@example.com --role=author

rem  ===Создание первичного контента===

rem php wp post create ./PAGE-CONTENT.txt --post_type=page --post_title='PAGE FROM FILE'
rem php wp post create ./about.txt --post_type=page --post_title='About'
rem php wp post create ./contact.txt --post_type=page --post_title='Contact'
rem php wp post create ./privacy.txt --post_type=page --post_title='Privacy Policy'

rem php wp post generate --count=10
rem curl http://loripsum.net/api/4 | wp post generate --post_content --count=10

goto %end

:noparam
echo "Site_name and DB_name required"
echo "Sample:"
echo "WP-setup-cli.bat SITE.ru db_name"

:end
pause
