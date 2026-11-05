# Assemble la démo en un seul fichier autonome : demo-amelioree/index.html
import base64, pathlib
here = pathlib.Path(__file__).parent
html = (here / 'demo.html').read_text()
logo = (here / 'logo.svg').read_text()
qr = base64.b64encode((here.parent.parent / 'logos' / 'qr-review.png').read_bytes()).decode()
html = html.replace('__LOGO__', logo).replace('__QR__', 'data:image/png;base64,' + qr)
(here.parent / 'index.html').write_text(html)
print('ok', len(html))
