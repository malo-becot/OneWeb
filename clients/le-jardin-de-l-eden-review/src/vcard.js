// Génère ../<Nom>.vcf à partir du bloc DONNÉES CLIENT de review.html
const fs = require('fs');
const html = fs.readFileSync(__dirname + '/review.html', 'utf8');
const C = Function('return ' + html.match(/var C = (\{[\s\S]*?\});/)[1])();
const e = s => String(s).replace(/[\\,;]/g, '\\$&');
const lines = [
  'BEGIN:VCARD', 'VERSION:3.0',
  `N:;${e(C.name)};;;`, `FN:${e(C.name)}`, `ORG:${e(C.name)}`, `TITLE:${e(C.activity)}`,
  `TEL;TYPE=WORK,VOICE:${C.tel}`,
  `URL:${C.web}`, `X-SOCIALPROFILE;TYPE=facebook:${C.facebook}`,
  `ADR;TYPE=WORK:;;${e(C.street)};${e(C.city)};;${C.zip};France`,
  `GEO:${C.geo.replace(',', ';')}`,
  'END:VCARD'
];
const fold = l => l.length <= 75 ? l : l.match(/.{1,74}/g).join('\r\n ');
fs.writeFileSync(__dirname + '/../' + C.name.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^\w-]+/g, '-') + '.vcf', lines.map(fold).join('\r\n') + '\r\n');
