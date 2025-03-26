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
});
