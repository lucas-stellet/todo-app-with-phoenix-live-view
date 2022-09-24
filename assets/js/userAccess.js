function setUserAccessKey() {
  const key = crypto.randomUUID();

  localStorage.setItem('_userAccessKey', key);

  return key;
}

function geteUserAccessKey() {
  return localStorage.getItem('_userAccessKey');
}

export function generateUserAccessKey() {
  const accessKey = localStorage.getItem('_userAccessKey');

  if (!accessKey) {
    return setUserAccessKey();
  }

  return geteUserAccessKey();
}
