# Assemble les sites du portfolio : portfolio-src/<metier>.html -> <metier>/index.html
# Repères remplacés : <!--HEAD-->, /*CSS*/, <!--BAR-->, <!--JS--> (définis dans common.html)
import pathlib, re
here = pathlib.Path(__file__).parent
common = (here / 'common.html').read_text()
part = lambda n: re.search(rf'<!--{n}-->\n(.*?)<!--/{n}-->', common, re.S).group(1)
for src in sorted(here.glob('*.html')):
    if src.name == 'common.html':
        continue
    s = src.read_text()
    s = s.replace('<!--HEAD-->', part('HEAD')).replace('/*CSS*/', part('CSS')).replace('<!--BAR-->', part('BAR')).replace('<!--JS-->', part('JS'))
    out = here.parent / src.stem / 'index.html'
    out.parent.mkdir(exist_ok=True)
    out.write_text(s)
    print(out.relative_to(here.parent), len(s))
