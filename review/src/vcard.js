// Génère ../<Nom>.vcf à partir du bloc DONNÉES CLIENT de review.html
const fs = require('fs');
const html = fs.readFileSync(__dirname + '/review.html', 'utf8');
const C = Function('return ' + html.match(/var C = (\{[\s\S]*?\});/)[1])();
const e = s => String(s).replace(/[\\,;]/g, '\\$&');
const photo = fs.readFileSync(__dirname + '/vcard-photo.jpg').toString('base64');
const lines = [
  'BEGIN:VCARD', 'VERSION:3.0',
  `N:;${e(C.name)};;;`, `FN:${e(C.name)}`, `ORG:${e(C.name)}`, `TITLE:${e(C.activity)}`,
  `TEL;TYPE=CELL,VOICE:${C.tel}`, `EMAIL;TYPE=INTERNET:${C.email}`,
  `URL:${C.web}`, `X-SOCIALPROFILE;TYPE=instagram:${C.insta}`,
  `ADR;TYPE=WORK:;;;;${e(C.region)};;France`,
  `PHOTO;ENCODING=b;TYPE=JPEG:${photo}`,
  'END:VCARD'
];
// Pliage des lignes à 75 caractères (norme vCard)
const fold = l => l.length <= 75 ? l : l.match(/.{1,74}/g).join('\r\n ');
const out = lines.map(fold).join('\r\n') + '\r\n';
const file = C.name.replace(/[^\w-]+/g, '-') + '.vcf';
fs.writeFileSync(__dirname + '/../' + file, out);
