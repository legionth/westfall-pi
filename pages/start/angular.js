angular.module('start', []).controller('startController', function($scope, $http) {
    
    $scope.load = function () {
    
    };
    $scope.load();

    $scope.save = function () {};
    
    $scope.refresh = function () {
        $http.get('/api/sensor').then(
            function successCallback(response) {
                console.log(response);
                $scope.moisturePercent = response.data;
                $scope.$pending = false;
            }, function(e) {
                $scope.$pending = false;
                return $e.reject(e.data.message);
            });
    };
});
