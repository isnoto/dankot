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
  this.sortPhotos(target);
};

Gallery.prototype.sortPhotos = function(target) {
  var sortCheck = target.getAttribute("data-sort");
  var imgs = this.elem.querySelector("#photo-container").querySelectorAll(".grid__item");
  var img;

  if (sortCheck == "all") {
    for (var j = 0; j < imgs.length; j++) {
      img = imgs[j];
      img.classList.add("shown");
    }

    this.masonry();
    return;
  }

  for (var i = 0; i < imgs.length; i++) {
    img = imgs[i];
    img.classList.add("shown");
    if(img.getAttribute("data-type") == sortCheck) continue;
    img.classList.remove("shown");
  }

  this.masonry();
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

Gallery.prototype.masonry = function() {
  var elem = document.querySelector('.grid');
  var msnry = new Masonry( elem, {
    "gutter": 20,
    itemSelector: '.grid__item',
    columnWidth: 300
  });
  
};

var gallery = new Gallery({elem: document.getElementById("gallery-inner")});

