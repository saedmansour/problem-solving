
// -------------------------------
//    wokamiApp
// -------------------------------

var wokamiApp = angular.module('wokamiApp', ['ngRoute', 'wokamiControllers', 'ngAnimate', 'monospaced.mousewheel', 'swipe', 'angulartics', 'angulartics.google.analytics']);
//var wokamiApp = angular.module('wokamiApp', ['ngRoute', 'wokamiControllers', 'monospaced.mousewheel', 'swipe', 'angulartics', 'angulartics.google.analytics']);



// -------------------------------
//    routing
// -------------------------------

wokamiApp.config(['$routeProvider', function($routeProvider) { $routeProvider.
  when('/', {
    templateUrl:   'partials/home.html',
    controller:  'HomeCtrl'
  }).
  when('/:pathId', {
    templateUrl: 'partials/path.html',
    controller: 'PathCtrl'
  }).
  when('/:pathId/posts/', {
    templateUrl:   'partials/intro.html',
    controller:  'PostCtrl'
  }).
    when('/:pathId/navigation/', {
    templateUrl: 'partials/navigation.html',
    controller: 'NavigationCtrl'
  }).
  when('/:pathId/posts/:postId', {
    templateUrl: 'post.html',
    controller: 'PostCtrl'
  }).
  when('/:pathId/chapters/:chapterId/posts/:postId', {
    templateUrl: 'partials/path.html',
    controller: 'PostCtrl'
  })
}]);




// -------------------------------
//    mySharedService: "global params"
// -------------------------------

wokamiApp.factory('mySharedService', function($rootScope, $location) {
  var sharedService = {};

  //sharedService.message = '';
  //sharedService.postsNum = 0;

  sharedService.message = 0;
  sharedService.postsNum = 0;
  sharedService.initialLocation = "";

  sharedService.prepForBroadcast = function(msg) {
    this.message = msg;
    this.broadcastItem();
  };

  sharedService.prepForBroadcastPostsNum = function(num) {
    this.postsNum = num;
    this.broadcastItem();
  };

  sharedService.prepForBroadcastInitialLocation = function(location) {
    this.initialLocation = location;
    this.broadcastItem();
  };

  sharedService.calcLocation = function() {
    var new_location = $location.path().slice(0, - 1);

    if($location.path().slice(-1) == "/") {
      new_location = $location.path().slice(0, - 1) + "/";
    }
    //return new_location;
    sharedService.initialLocation = new_location
  }

  sharedService.broadcastItem = function() {
    $rootScope.$broadcast('handleBroadcast');
  };

  return sharedService;
});



// ---------------------------------------------------------------------------
//    CONTROLELRS
// ---------------------------------------------------------------------------


// -------------------------------
//    indexController
// -------------------------------

wokamiApp.controller('indexController', ['$scope', '$location', '$route', '$routeParams', 'mySharedService', function($scope, $location ,$route, $routeParams, sharedService) {
  $scope.effect = 'slidedown';

  /*
  $scope.swipe = function (event) {
    console.log("whaaaaaaaaat");
  };*/

  $scope.keyUp = function (event) {
    console.log('key up event fired');
    if(event.keyCode == 38) { //38 = arrow up key
      $scope.prevPost();
    } else if (event.keyCode == 40) { // 40 arrow down key
      $scope.nextPost();
    }
  };

  $scope.isMobile = function (){
    if( /Android|webOS|iPhone|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
      return true;
    }
    return false;
  }

  $scope.trackEvent = function() {
    //$window.ga('send', 'pageview', { page: $location.path() });
  }

  $scope.isPrevPost = function (){
    if(parseInt(sharedService.message) - 1 <= 0) {
      return false;
    }
    return true;
  }

  $scope.isNextPost = function (){
    if( parseInt(sharedService.message) + 1 > parseInt(sharedService.postsNum) ) {
      console.log("false")
      return false;
    }
    console.log("true")
    return true;
  }

  /*$scope.calc_location = function() {
    var new_location = $location.path().slice(0, - 1);

    if($location.path().slice(-1) == "/") {
      new_location = $location.path().slice(0, - 1) + "/";
    }
    return new_location;
  }*/
  
  sharedService.calcLocation();

  $scope.prevPost = function() {
    if(!$scope.isPrevPost()) {
      return;
    }
    //$rootScope.myVar = 'slideup';
    $scope.effect = 'slidedown';
    //$scope.calc_location();
    $location.path(sharedService.initialLocation + ((parseInt(sharedService.message) - 1)).toString());      
    sharedService.prepForBroadcast((parseInt(sharedService.message) - 1));
  }

  $scope.nextPost = function() {
    if(!$scope.isNextPost()) {
      console.log("what");
      return;
    }
    console.log("whataaa");
    //trianglifyBackground();
    //$rootScope.myVar = 'slidedown';
    $scope.effect = 'slideup';
    //$location.path($scope.initial_location + ( (parseInt(sharedService.message) + 1) ).toString());
    //console.log("hello world")
    //console.log($scope.initial_location + ( (parseInt(sharedService.message) + 1) ).toString());
    //$scope.calc_location();
    if(sharedService.message == 1) { 
      sharedService.calcLocation();
    }
    next_page_id = (parseInt(sharedService.message + 1)).toString();
    $location.path(sharedService.initialLocation + next_page_id);
        //update global of current "feed's post id"
    sharedService.prepForBroadcast((parseInt(sharedService.message) + 1));
  }

  /*$scope.goNavigationOrFeed = function () {
    initial_location = $location.path();
    if($scope.subject.is_navigation) {
      $location.path("/" + $routeParams.pathId + "/navigation");      
    } else {
      $scope.nextPost();
    }
  }*/

  //angular-mousewheel
  $scope.test1 =  function(event, delta, deltaX, deltaY){
    // fixes an error with mousepad
    //    it is fixable without it, need to talk to Oli
    //
    if(Math.abs(deltaY) > 1 || deltaY == undefined) {
      return;
    }

    var pageX = event.pageX || event.originalEvent.pageX || event.originalEvent.clientX,
        pageY = event.pageY || event.originalEvent.pageY || event.originalEvent.clientX;
    
    if(deltaY > 0) {
     $scope.prevPost();
    } else {
      $scope.nextPost();
    }
  }
}]);


// -------------------------------
//    PostCtrl
// -------------------------------

var wokamiControllers = angular.module('wokamiControllers', []);

wokamiControllers.controller('PostCtrl', [ '$scope','$location','$route', '$routeParams', 'mySharedService', '$sce', '$http', '$window', function ($scope, $location, $route, $routeParams, sharedService, $sce, $http, $window) {

  //Navigation
  /*$http.get('/api/subjects/' + $routeParams.pathId + '/chapters.json').success(function(data) {
    $scope.chapters = data;
  });*/
  //

    //if intro page of learning path
  if ($routeParams.postId == undefined) {
    $routeParams.postId = 0;
    //$scope.effect = 'show';
  } 

  $scope.currentPostId = $routeParams.postId

  //sharedService.prepForBroadcast($routeParams.postId);

  $scope.code = 'AWcglbj5sWM';

  //DATA URL
  var dataUrl = $sce.trustAsResourceUrl('/api/subjects/' + $routeParams.pathId + '/posts.json')
  if($routeParams.chapterId != undefined) {
    var dataUrl = $sce.trustAsResourceUrl('/api/subjects/' + $routeParams.pathId + '/chapters/' + $routeParams.chapterId  + '/posts.json');
  }

  //GET POSTS
  $http.get(dataUrl).success(function(data) {
    $scope.posts   = data.posts;
    $scope.subject = data.subject;
    $scope.pathName = $scope.subject.name;
    $scope.backgroundImage = $scope.subject.image;
    $scope.backgroundColor = $scope.subject.background_color;
    $scope.opacity = $scope.subject.image_css;
    $scope.titlesColor = $scope.subject.intro_page_titles_color;

    sharedService.prepForBroadcastPostsNum($scope.posts.length);
  
    //active post
    $scope.post = $scope.posts[$scope.currentPostId-1];
    $scope.post.details = $sce.trustAsHtml($scope.post.details);
    if(!$scope.post.background_color) {
      $scope.post.background_color =  Please.make_color();
    }
  });

  //GoNavigationOrFeed: when in the intro page clicking the "next/arrow button"
  //  decide whether to jump to navigation if there's any, otherwise to posts.
  $scope.goNavigationOrFeed = function () {
    sharedService.prepForBroadcast(1); //initialize post number
    //sharedService.prepForBroadcast((parseInt(sharedService.message) + 1));

    initial_location = $location.path();
    if($scope.subject.is_navigation) {
      $location.path("/" + $routeParams.pathId + "/navigation");
    } else {
      $scope.nextPost();
    }
  }

  $scope.$on('$routeChangeSuccess', function () {
    //google analytics: on route change count page view.
    $('#start').addClass('animated bounce');
    $window.ga('send', 'pageview', { page: $location.path() });
  });

}]);




// -------------------------------
//    PathCtrl
// -------------------------------


wokamiControllers.controller('PathCtrl', [ '$scope','$location','$route', '$routeParams', 'mySharedService', '$sce', '$http', '$window', function ($scope, $location, $route, $routeParams, sharedService, $sce, $http, $window) {

  console.log("routeparam: " + $routeParams.pathId)
  if ($routeParams.pathId == undefined) {
    $routeParams.pathId = 0;
  } 

  $scope.currentPathId = $routeParams.pathId;

  //sharedService.prepForBroadcast($routeParams.postId);

  $scope.code = 'AWcglbj5sWM';

  //var dataUrl = $sce.trustAsResourceUrl('/api/subjects/paths.json')
  var dataUrl = '/api/subjects/paths.json'

  //delete $http.defaults.headers.common['X-Requested-With'];

  $http.get(dataUrl).success(function(data) {
    $scope.posts   = data.posts;

    //update posts num for knowing when is(Next/Prev)Post
    console.log("scope posts length: " + $scope.posts.length);
    sharedService.prepForBroadcastPostsNum($scope.posts.length);
  
    //active post
    $scope.post = $scope.posts[$scope.currentPathId-1];
    if($scope.post.sample != null) {
      $scope.post.content = $sce.trustAsHtml($scope.post.sample.details);
      console.log("hello world")
    } else {
      $scope.post.content = "";
    }
    //$scope.post.details = $sce.trustAsHtml($scope.post.details);
    
    //if(!$scope.post.background_color) {
      $scope.post.background_color =  Please.make_color();
      $scope.post.title = $sce.trustAsHtml($scope.post.name + " - <i>demo</i>");
      $scope.post.is_subect = true;
    //}
  });


  $scope.$on('$routeChangeSuccess', function () {
    //google analytics: on route change count page view.
    $('#start').addClass('animated bounce');
    //$('#open-path').addClass('animated shake');
    //$window.ga('send', 'pageview', { page: $location.path() });
  });

}]);  // wokamicontrollers


// -------------------------------
//    homeController: show a feed of "subjects (aka paths/flows)"
// -------------------------------

wokamiApp.controller('HomeCtrl', ['$scope', '$location', '$route', '$routeParams', '$http', 'mySharedService', function($scope, $location ,$route, $routeParams, $http, sharedService) {

  $scope.effect = 'slideup-onleave';

  sharedService.prepForBroadcast(0);

  $http.get('/api/subjects/paths.json').success(function(data) {
    sharedService.prepForBroadcastPostsNum(data.posts.length);
  });

  $scope.background_color =  Please.make_color();

  $scope.$on('$routeChangeSuccess', function () {
    if(parseInt(sharedService.message) == 0) {
      //$('#start').addClass('animated bounce');  
    }
    //if(parseInt(sharedService.message) > 0) {
    //}
  });
}]);

// -------------------------------
//    NavigationCtrl: present the path.
// -------------------------------

wokamiControllers.controller('NavigationCtrl', ['$scope', '$location', '$route', '$routeParams', '$http', 'mySharedService', function($scope, $location ,$route, $routeParams, $http, sharedService) {
   $scope.effect = 'slideup-onleave';  

   $http.get('/api/subjects/' + $routeParams.pathId + '/chapters.json').success(function(data) {
    $scope.chapters = data;
  });

}]);



// -------------------------------
//    Directive
//      youtube: currently unused
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
//    helper functions: getParameterByName: JavaScript function to get Params 
// -------------------------------

function getParameterByName(name) {
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
  var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
      results = regex.exec(location.search);
  return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// -------------------------------
//    RandomColor: unused currently
// -------------------------------

function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomColor() {
  colors = ["lavender", "OldLace ", "lightblue", "PeachPuff ", "PaleVioletRed ", "SteelBlue "];
  return colors[getRandomInt(0,colors.length-1)];
}


// -------------------------------
//    background coloring
// -------------------------------

//not used currently: very heavy and slow. need optimization but very pretty.
function trianglifyBackground() {
  var t = new Trianglify();
  var pattern = t.generate(document.getElementById('post').clientWidth, document.getElementById('post').clientHeight);
  //console.log(document.body.innerHeight)
  $('.post').attr('style', 'background-image: ' + pattern.dataUrl);
  return pattern.dataUrl;
}

function colorifyBackground() {
  newColor =   Please.make_color();
  $('.post:eq(1)').attr('style', 'background-color: ' + newColor);
}

// -------------------------------
//    Animation config.
//      unhide post
// -------------------------------

wokamiApp.animation('.slidedown', function(){
  return { 
      enter: function(element, done) {
        console.log('enter');
          //setTimeout(function() { trianglifyBackground(); }, 1100);
          //colorifyBackground();
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
          //setTimeout(function() { trianglifyBackground(); }, 1100);
          //colorifyBackground();
          return function(cancelled) {
            console.log('done/cancelled');
              //this (optional) function will be called when the animation
              //completes or when the animation is cancelled (the cancelled
              //flag will be set to true if cancelled).
          };
      }
  };
})
