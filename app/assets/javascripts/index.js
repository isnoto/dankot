function Gallery(options) {
  var elem = this.elem = options.elem;

  elem.addEventListener("click", function(event) {
    this.checkAction(event);
  }.bind(this));

  window.addEventListener("keydown", function(event) {
    if (event.keyCode == 27) {
      this.closePopup();
    }

  }.bind(this));

}

Gallery.prototype.checkAction = function(event) {
  var target = event.target;
  if (!target.hasAttribute("data-action")) {
    target = event.target.parentNode;
  }


  var action = target.getAttribute("data-action");

  switch (action) {

    case 'sort':
      event.preventDefault();
      this.changeSortClass(target);
      break;

    case 'view-photo':
      this.showPopup(target);
      break;

    case 'change-photo':
      event.preventDefault();
      this.checkDirection(target);
      break;

    case 'close':
      event.preventDefault();
      this.closePopup(event);
      break;

    case 'open-window':
      event.preventDefault();
      this.newWindow();
      break;
  }
};

Gallery.prototype.changeSortClass = function(target) {
  var links = target.parentNode.querySelectorAll("li");

  for (var i = 0; i < links.length; i++) {
    var link = links[i];
    link.classList.remove("sort-photos__item--active");
  }

  target.classList.add("sort-photos__item--active");
};

Gallery.prototype.showPopup = function(target) {
  document.body.style.overflow = "hidden";
  var viewPhoto = document.querySelector(".view-photo");
  var imgPhotoWrap = viewPhoto.querySelector(".view-photo__image");
  var targetBigImg = target.firstChild.getAttribute("data-realsize");
  var targetImgSrc = target.firstChild.getAttribute("data-zoom-src");
  var imgContainers = this.elem.querySelector("#photo-container").querySelectorAll(".grid__item");

  if (!viewPhoto.classList.contains("shown")) {
    viewPhoto.classList.add("shown");
  }

  for (var i = 0; i < imgContainers.length; i++) {
    var imgContainer = imgContainers[i];
    imgContainer.classList.remove("current");
  }

  target.classList.add("current");
  imgPhotoWrap.setAttribute("src", targetImgSrc);
  imgPhotoWrap.setAttribute("data-realsize", targetBigImg);
};


Gallery.prototype.closePopup = function() {
  document.body.style.overflow = "auto";

  var viewPhoto = document.querySelector(".view-photo");
  viewPhoto.classList.remove("shown");
};

Gallery.prototype.checkDirection = function(target) {
  var direction = target.getAttribute("data-direction");

  switch (direction) {
    case 'prev' :
      this.prev();
      break;
    case 'next' :
      this.next();
      break;
  }
};

Gallery.prototype.next = function() {
  var imgs = this.elem.querySelector("#photo-container").querySelectorAll(".grid__item");
  var nextImg;

  for (var i = 0; i < imgs.length; i++) {
    var img = imgs[i];
    var pos;

    if (!img.classList.contains("current")) continue;
    img.classList.remove("current");
    pos = i;
    break;
  }

  if (!imgs[pos].nextElementSibling) {
    nextImg = imgs[0].firstChild;
  } else {
    nextImg = imgs[pos].nextElementSibling.firstChild;
  }

  this.changePhoto(nextImg);
};

Gallery.prototype.prev = function() {
  var imgs = this.elem.querySelector("#photo-container").querySelectorAll(".grid__item");
  var nextImg;

  for (var i = 0; i < imgs.length; i++) {
    var img = imgs[i];
    var pos;

    if (!img.classList.contains("current")) continue;
    img.classList.remove("current");
    pos = i;
    break;
  }

  if (!imgs[pos].previousElementSibling) {
    nextImg = imgs[imgs.length - 1].firstChild;
  } else {
    nextImg = imgs[pos].previousElementSibling.firstChild;
  }

  this.changePhoto(nextImg);
};

Gallery.prototype.changePhoto = function (target) {
  var viewPhoto = document.querySelector(".view-photo");
  var imgPhoto = viewPhoto.querySelector(".view-photo__image");


  imgPhoto.setAttribute("src", target.getAttribute("data-zoom-src"));
  imgPhoto.setAttribute("data-realsize", target.getAttribute("data-realsize"));
  target.parentNode.classList.add("current");
};

Gallery.prototype.newWindow = function() {
  var viewPhoto = document.querySelector(".view-photo");
  var imgPhoto = viewPhoto.querySelector(".view-photo__image");

  window.open(imgPhoto.getAttribute("data-realsize"));
};

function Carousel(options) {
  var elem = this.elem = options.elem;
  this.position = 0;

  elem.addEventListener("click", function(event){
    this.checkDirection(event);
  }.bind(this));

  elem.addEventListener("keypress", function(event){
    this.checkDirection(event);
  }.bind(this))
}

Carousel.prototype.checkDirection = function(event) {
  var direction = event.target.getAttribute("data-direction");

  switch (direction) {
    case 'prev' :
      this.prev(this.elem.offsetWidth);
      break;
    case 'next' :
      this.next(this.elem.offsetWidth);
      break;
  }
};

Carousel.prototype.next = function (width) {
  this.position += -width;
  var w = width, img = this.elem.querySelectorAll('div.gallery-main__photo-wrap');
  for (var i=0; i<img.length; i++) {
    w -= (img[i].offsetWidth + 20)

  }

  w += 20;
  // if (w > this.position)  this.position = w;
  this.position = Math.max(w, this.position);
  this.elem.querySelector('.gallery-main__photos').style.marginLeft = this.position + 'px';
};

Carousel.prototype.prev = function(width) {
  this.position += +width;

  if (this.position >= 0) {
    this.elem.querySelector(".gallery-main__photos").style.marginLeft = 0 + "px";
    this.position = 0;
  }

  this.elem.querySelector(".gallery-main__photos").style.marginLeft = this.position + "px";
};

function portfolio() {
  function initPortfolio() {
    var loading=true;
    $.ajax({
      url: '/photos?page=1&id=1',
      type: 'get',
      dataType: 'script',
      success: function(data) {
        var arr = JSON.parse(data);
        console.log(data);
        initMasonry();
        appendItems(arr);
        loading=false;

        initInfiniteScroll();
      }
    });
  }

  initPortfolio();

  function initMasonry() {
    var $container = $('#photo-container');
    $container.imagesLoaded(function() {
      $container.masonry({
        itemSelector: '.grid__item',
        gutter: 20,
        columnWidth: 300
      });
    });
  }

  function initInfiniteScroll() {
    var page = 1,
      loading = false;

    function nearBottomOfPage() {
      return $(window).scrollTop() > $(document).height() - $(window).height() - 200;
    }

    $(window).scroll(function(){
      if (loading) {
        return;
      }

      if(nearBottomOfPage()) {
        loading=true;
        page++;
        $.ajax({
          url: '/photos?page=' + page+'&id=1',
          type: 'get',
          dataType: 'script',
          success: function(data) {
            appendItems(data);

            loading=false;
          }
        });
      }
    });
  }

  function appendItems(arr) {
    var $container = $('#photo-container');

    var fragment = document.createDocumentFragment();
    var elems = [];

    elems = arr.map(function(item) {
      var $elem = $('<div class="grid__item"><img src="' + item.image.portfolio.url + '" /></div>');
      $elem.hide();
      // get DOM element, not jQuery
      var elem = $elem[0];
      // add element, not jQuery, to fragment
      fragment.appendChild( elem );
      return elem
    });
    // append elems to container
    $container.append( fragment );

    $container.imagesLoaded(function() {
      // show items once all visible
      $( elems ).show();
      $container.masonry( 'appended', elems )
    });
  }
}

window.onload = function() {
  if (document.getElementById("gallery")) {
    var carousel = new Carousel({elem: document.getElementById("gallery")});
  } else {
    if (document.getElementById("gallery-inner")) {
      portfolio();
      var gallery = new Gallery({elem: document.getElementById("gallery-inner")});
    }
  }
};








