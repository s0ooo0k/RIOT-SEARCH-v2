document.addEventListener("DOMContentLoaded", function () {
  // 페이지 로드 시 페이드인 효과 적용
  const elements = document.querySelectorAll(".fade-in");
  elements.forEach((element) => {
    element.style.opacity = "1";
    element.style.transform = "translateY(0)";
  });

  // 입력 필드 포커스 효과
  const inputs = document.querySelectorAll(".form-control");
  inputs.forEach((input) => {
    input.addEventListener("focus", function () {
      this.parentElement.classList.add("focused");
    });
    input.addEventListener("blur", function () {
      this.parentElement.classList.remove("focused");
    });
  });

  // 버튼 호버 효과
  const buttons = document.querySelectorAll(".btn-primary");
  buttons.forEach((button) => {
    button.addEventListener("mouseover", function () {
      this.style.transform = "translateY(-2px)";
    });
    button.addEventListener("mouseout", function () {
      this.style.transform = "translateY(0)";
    });
  });

  // Three.js 파티클 애니메이션
  if (document.getElementById("particle-canvas")) {
    initParticleAnimation();
  }
});

function initParticleAnimation() {
  const canvas = document.getElementById("particle-canvas");
  const ctx = canvas.getContext("2d");
  let particles = [];
  const particleCount = 50;

  // 캔버스 크기 설정
  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }
  resizeCanvas();
  window.addEventListener("resize", resizeCanvas);

  // 파티클 클래스
  class Particle {
    constructor() {
      this.x = Math.random() * canvas.width;
      this.y = Math.random() * canvas.height;
      this.size = Math.random() * 2 + 1;
      this.speedX = Math.random() * 0.5 - 0.25;
      this.speedY = Math.random() * 0.5 - 0.25;
      this.color = `rgba(201, 170, 113, ${Math.random() * 0.5 + 0.2})`;
    }

    update() {
      this.x += this.speedX;
      this.y += this.speedY;

      if (this.x < 0 || this.x > canvas.width) this.speedX *= -1;
      if (this.y < 0 || this.y > canvas.height) this.speedY *= -1;
    }

    draw() {
      ctx.fillStyle = this.color;
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
      ctx.fill();
    }
  }

  // 파티클 초기화
  for (let i = 0; i < particleCount; i++) {
    particles.push(new Particle());
  }

  // 애니메이션 루프
  function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    particles.forEach((particle) => {
      particle.update();
      particle.draw();
    });
    requestAnimationFrame(animate);
  }
  animate();
}
