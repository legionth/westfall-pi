<?php
namespace WestfallPi\Service;

class MoistureSensorService
{
    public function fetchMoistureInPercent()
    {
        return exec('/usr/bin/python /var/www/src/service/scripts/fetchMoistureInPercent.py');
    }
}
