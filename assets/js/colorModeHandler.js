export function setColor(newColorMode) {
  localStorage.setItem('colorMode', newColorMode);
}

export function getCurrentColor() {
  return localStorage.getItem('colorMode');
}

export function changeToDarkMode() {
  document.getElementById('todo-app').style.backgroundColor = '#171823';
  setColor('dark');
}

export function changeToLightMode() {
  document.getElementById('todo-app').style.backgroundColor = '#F2F2F2';
  setColor('light');
}

export function setInitialColorMode() {
  const colorMode = getCurrentColor();

  if (!colorMode) {
    setColor('light');
  } else if (colorMode == 'dark') {
    changeToDarkMode();
  }
}

export function changeColorMode() {
  const colorMode = getCurrentColor();

  if (colorMode == 'light') {
    changeToDarkMode();
  } else {
    changeToLightMode();
  }
}
