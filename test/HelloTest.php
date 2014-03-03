<?php
use Silex\WebTestCase;

class HelloTest extends WebTestCase
{
    public function createApplication()
    {
        $app = require __DIR__.'/../src/app.php';
        $app['debug'] = true;
        $app['exception_handler']->disable();

        return $app;
    }

    public function testHelloReturnsNameWithGet()
    {
        $client = $this->createClient();
        $client->request(
            'GET',
            '/hello/Mario'
        );

        $this->assertEquals(200, $client->getResponse()->getStatusCode());
        $this->assertEquals('{"message":"Hello Mario"}', $client->getResponse()->getContent());
        $this->assertEquals('application/json', $client->getResponse()->headers->get('Content-Type'));
    }
}
