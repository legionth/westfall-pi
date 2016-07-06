<?php
use Slim\Slim;
use WestfallPi\Service\MoistureSensorService;

require_once 'vendor/autoload.php';

$loader = new Twig_Loader_Filesystem(array(__DIR__ . '/templates/', __DIR__ . '/pages/'));
$twig = new Twig_Environment($loader);

/**
 * create a controller action to view the given twig template $name
 *
 * @param string $name
 * @return callable
 */
$view = function ($name) use ($twig) {
	return function () use ($name, $twig) {
		echo $twig->render($name . '/view.html.twig');
	};
};

$slim = new Slim();

$slim->get('/api/sensor', function () use ($slim) {
    $service = new MoistureSensorService();
    $result = $service->fetchMoistureInPercent();
    echo $result;
});

$slim->get('/', function () use ($slim) {
    $slim->redirect('/start');
});

$slim->get('/start', $view('start'));   


// Make every angular.js
$slim->get('/js/:name.js', function ($name) use ($slim) {
    if (!file_exists(__DIR__ . '/pages/' . $name .'/angular.js')) {
        $slim->halt(404);
    }
    $slim->response->headers()->set('Content-Type', 'application/javascript');
    readfile(__DIR__ . '/pages/' . $name . '/angular.js');
});

$slim->run();
