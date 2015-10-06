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


var carousel = new Carousel({elem: document.getElementById("gallery")});