// Constants

var infoExample = 
        "<ul class='info'> \
          <li><b>Dialect</b>: MSA mostly and Palestinian</li> \
          <li><b>Content examples</b>: essential arabic phrases, alphabet, grammar, ...</li> \
          <li><b>Level</b>: beginner-intermediate</li> \
          <li><b>Format</b>: short videos, entertaining</li> \
          <li><b>Bonus</b>: culture, arabic food recepies, great teacher</li> \
          <li><b>Rating</b>: 60k+ fb followers, youtube: ~100k-1m per video</li> \
        </ul>";



// -------------------------------
//    wokamiApp
// -------------------------------

var wokamiApp = angular.module('wokamiApp', ['ngRoute', 'wokamiControllers', 'ngAnimate', 'monospaced.mousewheel']);

//

wokamiApp.factory('mySharedService', function($rootScope) {
  var sharedService = {};

  sharedService.message = '';
  sharedService.postsNum = 0;

  sharedService.prepForBroadcast = function(msg) {
    this.message = msg;
    this.broadcastItem();
  };

  sharedService.prepForBroadcastPostsNum = function(num) {
    this.postsNum = num;
    this.broadcastItem();
  };

  sharedService.broadcastItem = function() {
    $rootScope.$broadcast('handleBroadcast');
  };

  return sharedService;
});



// -------------------------------
//    routing
// -------------------------------

wokamiApp.config(['$routeProvider', function($routeProvider) { $routeProvider.
  when('/', {
    templateUrl:   'post.html',
    controller:  'PostCtrl'
  }).
  when('/:postId', {
    templateUrl: 'post.html',
    controller: 'PostCtrl'
  }) 
} ]);

// -------------------------------
//    indexController
// -------------------------------

wokamiApp.controller('indexController', ['$scope', '$location', '$route', '$routeParams', 'mySharedService', function($scope, $location ,$route, $routeParams, sharedService) {
  $scope.effect = 'slidedown';

  $scope.keyUp = function (event) {
    console.log('key up event fired');
    if(event.keyCode == 38) { //38 = arrow up key
      $scope.prevPost();
    } else if (event.keyCode == 40) { // 40 arrow down key
      $scope.nextPost();
    }
  };

  $scope.isPrevPost = function (){
    if(parseInt(sharedService.message) - 1 <= 0) {
      return false;
    }
    return true;
  }
  $scope.isNextPost = function (){
    if( parseInt(sharedService.message) + 1 > parseInt(sharedService.postsNum) ) {
      return false;
    }
    return true;
  }

  $scope.prevPost = function() {
    if(!$scope.isPrevPost()) {
      return;
    }
    //$rootScope.myVar = 'slideup';
    $scope.effect = 'slidedown';
    //console.log((parseInt(sharedService.message) - 1).toString());
    $location.path((parseInt(sharedService.message) - 1).toString());      
  }

  $scope.nextPost = function() {
    if(!$scope.isNextPost()) {
      return;
    }
    //trianglifyBackground();
    //$rootScope.myVar = 'slidedown';
    $scope.effect = 'slideup';
    //console.log($location.path());      
    //console.log((parseInt(sharedService.message) + 1).toString());
    $location.path((parseInt(sharedService.message) + 1).toString());
  }

  //angular-mousewheel
  $scope.test1 =  function(event, delta, deltaX, deltaY){
    var pageX = event.pageX || event.originalEvent.pageX || event.originalEvent.clientX,
        pageY = event.pageY || event.originalEvent.pageY || event.originalEvent.clientX;
    
    if(deltaY > 0) {
     $scope.prevPost();
    } else {
    $scope.nextPost();
    }
    //console.log(event)
  }
}]);


// -------------------------------
//    PostCtrl
// -------------------------------

var wokamiControllers = angular.module('wokamiControllers', []);

wokamiControllers.controller('PostCtrl', [ '$scope', '$location','$route', '$routeParams', 'mySharedService', '$sce', function ($scope, $location, $route, $routeParams, sharedService, $sce) {


  if ($routeParams.postId == undefined) {
    $routeParams.postId = 1;
  } 

  $scope.currentPostId = $routeParams.postId

  sharedService.prepForBroadcast($routeParams.postId);

  $scope.code = 'AWcglbj5sWM';

  $scope.pathName = "Arabic";

  $scope.posts = [
  {
    id: 1,
    title: "Learn Arabic with Maha", 
    url: "https://www.youtube.com/user/LearnArabicwithMaha",
    image: "maha.jpg",
    image_height: "330px",
    details: $sce.trustAsHtml(infoExample)
    /*backgroundColor: 'SteelBlue' */
  }, 
  {
    id: 2,
    title: "AHA", 
    url: "https://www.youtube.com/user/LearnArabicwithMaha",
    image: "maha.jpg",
    image_height: "330px",
    details: infoExample,
  }, 
  {
    id: 3,
    title: "arbiaaa", 
    url: "https://www.youtube.com/user/LearnArabicwithMaha",
    image: "maha.jpg",
    image_height: "330px",
    details: infoExample,
  }];

  sharedService.prepForBroadcastPostsNum($scope.posts.length);
  
  //active post
  $scope.post = $scope.posts[$scope.currentPostId-1];

  $scope.$on('$routeChangeSuccess', function () {
    //trianglifyBackground();
  });

  /*$scope.nextPost = function() {
    $scope.post = {
      title: "hell yea!",
      pathTitle : "Arabic / Basic Path / Greetings"   
    }
  }

  $scope.previousPost = function() {
    $scope.post = {
      title: "mother god!",
      pathTitle : "Arabic / Basic Path / Chicks"   
    }
  }*/



}]);  // wokamicontrollers




// -------------------------------
//    Animation config.
//      unhide post
// -------------------------------



// -------------------------------
//    Directive
//      youtube
// -------------------------------


wokamiApp.directive('myYoutube', function($sce) {
  return {
    scope: { code: '=' },
    replace: true,
    template: '<div style="overflow:hidden;height:400px;width:533px;" id="post-content" src="{{url}}" frameborder="0" allowfullscreen></div>',
    link: function (scope) {
        //console.log(scope.code);
        scope.$watch('code', function (newVal) {
           if (newVal) {
               scope.url = $sce.trustAsResourceUrl("http://www.youtube.com/embed/" + newVal);
           }
        });
    }
  };
});

// -------------------------------
//    RandomColor
// -------------------------------

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomColor() {
  colors = ["lavender", "OldLace ", "lightblue", "PeachPuff ", "PaleVioletRed ", "SteelBlue "];
  return colors[getRandomInt(0,colors.length-1)];
}


// -------------------------------
//    Trianglify
// -------------------------------

function trianglifyBackground() {
  var t = new Trianglify();
  var pattern = t.generate(document.getElementById('post').clientWidth, document.getElementById('post').clientHeight);
  console.log(document.body.innerHeight)
  $('.post').attr('style', 'background-image: ' + pattern.dataUrl);
  return pattern.dataUrl;
}

// -------------------------------
//    Animation config.
//      unhide post
// -------------------------------

wokamiApp.animation('.slidedown', function(){
  return { 
      enter: function(element, done) {
        console.log('enter');
          setTimeout(function() { trianglifyBackground(); }, 1100);
          return function(cancelled) {
            console.log('done/cancelled');
              //this (optional) function will be called when the animation
              //completes or when the animation is cancelled (the cancelled
              //flag will be set to true if cancelled).
          };
      }
  };
})

wokamiApp.animation('.slideup', function(){
  return { 
      enter: function(element, done) {
        console.log('enter');
          setTimeout(function() { trianglifyBackground(); }, 1100);
          return function(cancelled) {
            console.log('done/cancelled');
              //this (optional) function will be called when the animation
              //completes or when the animation is cancelled (the cancelled
              //flag will be set to true if cancelled).
          };
      }
  };
})
