<?php
use Cake\Database\Connection;
use Cake\Database\Driver\Mysql;
use Cake\Mailer\Transport\SmtpTransport;
/*
 * Local configuration file to provide any overrides to your app.php configuration.
 * Copy and save this file as app_local.php and make changes as required.
 * Note: It is not recommended to commit files with credentials such as app_local.php
 * into source code version control.
 */

/**
 * for testing purpose, remove from production configuration
 */

return [
    /*
     * Debug Level:
     *
     * Production Mode:
     * false: No error messages, errors, or warnings shown.
     *
     * Development Mode:
     * true: Errors and warnings shown.
     */
    'debug' => filter_var(env('DEBUG', true), FILTER_VALIDATE_BOOLEAN),
    'Error' => [
        'errorLevel' => E_ALL & ~E_USER_DEPRECATED
    ],
    /*
     * Security and encryption configuration
     *
     * - salt - A random string used in security hashing methods.
     *   The salt value is also used as the encryption key.
     *   You should treat it as extremely sensitive data.
     */
    'Security' => [
        'salt' => env('SECURITY_SALT', 'a68119f0964adc782ef0b13de50b27398fe2f74fd147e66629ed0744fb395631'),
    ],

    /*
     * Connection information used by the ORM to connect
     * to your application's datastores.
     *
     * See app.php for more configuration options.
     */
    'Datasources' => [
        'default' => [
            'className' => Connection::class,
            'driver' => Mysql::class,
            'persistent' => false,
            'timezone' => 'System',
            'host' => 'mariadb.job',
            'port' => 3306,
            'username' => env('MARIADB_USERNAME', 'root'),
            'password' => env('MARIADB_PASSWORD', ''),

            'database' => 'job_search',
            'encoding' => 'utf8',
            'flags' => [],
            'cacheMetadata' => true,
            'log' => true,

            /*
             * Set identifier quoting to true if you are using reserved words or
             * special characters in your table or column names. Enabling this
             * setting will result in queries built using the Query Builder having
             * identifiers quoted when creating SQL. It should be noted that this
             * decreases performance because each query needs to be traversed and
             * manipulated before being executed.
             */
            'quoteIdentifiers' => false,

            /*
             * During development, if using MySQL < 5.6, uncommenting the
             * following line could boost the speed at which schema metadata is
             * fetched from the database. It can also be set directly with the
             * mysql configuration directive 'innodb_stats_on_metadata = 0'
             * which is the recommended value in production environments
             */
            //'init' => ['SET GLOBAL innodb_stats_on_metadata = 0'],
        ],

        /*
         * The test connection is used during the test suite.
         */
        'test' => [
            'host' => 'localhost',
            //'port' => 'non_standard_port_number',
            'username' => 'my_app',
            'password' => 'secret',
            'database' => 'test_myapp',
            //'schema' => 'myapp',
        ],
    ],

    'Email' => [
        'default' => [
            'transport' => 'default',
            'from' => env('MAIL_FROM'),
            'is_test' => env('MAIL_IS_TEST', true),
            'test_mail_receiver' => env('MAIL_TEST_MAIL_TO', 'feilfly+test@gmail.com'),
            'log' => true,
            /*
             * Will by default be set to config value of App.encoding, if that exists otherwise to UTF-8.
             */
            //'charset' => 'utf-8',
            //'headerCharset' => 'utf-8',
        ],
    ],

    /*
     * Email configuration.
     *
     * Host and credential configuration in case you are using SmtpTransport
     *
     * See app.php for more configuration options.
     */
    'EmailTransport' => [
        'default' => [
            'className' => SmtpTransport::class,
            /*
             * The keys host, port, timeout, username, password, client and tls
             * are used in SMTP transports
             */
            'host' => env('MAIL_HOST'),
            'port' => env('MAIL_PORT'),
            'timeout' => 30,
            /*
             * It is recommended to set these options through your environment or app_local.php
             */
            'username' => env('MAIL_USERNAME'),
            'password' => env('MAIL_PASSWORD'),
            'client' => null,
            'tls' => true,
            'url' => env('EMAIL_TRANSPORT_DEFAULT_URL', null),
        ],
    ],
    'OpenAI' => [
        'apiKey' => env('OPENAI_KEY', null),
        'model' => 'gpt-4'
    ],

    'DebugKit' => [
        'forceEnable' => true
    ],

];

