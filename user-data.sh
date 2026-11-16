#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
cat << 'EOF' > /var/www/html/index.html

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Class Notes Hub</title>
<style>
:root{color-scheme:dark;--panel:#151e33;--text:#edf2ff;--muted:#a8b4cc;--accent:#8b9cff;--line:#293653}
*{box-sizing:border-box}
body{margin:0;background:linear-gradient(145deg,#0b1020,#111b31);color:var(--text);font:16px/1.5 Arial,sans-serif;min-height:100vh}
main{width:min(900px,92%);margin:auto;padding:48px 0}
header{text-align:center;margin-bottom:28px}
.tag{color:#aab7ff;text-transform:uppercase;letter-spacing:2px;font-size:.75rem;font-weight:bold}
h1{font-size:clamp(2rem,6vw,3.3rem);margin:8px 0}
header p,.card p{color:var(--muted)}
.filters{display:flex;justify-content:center;gap:10px;flex-wrap:wrap;margin:26px 0}
button{border:1px solid var(--line);background:var(--panel);color:var(--text);padding:10px 18px;border-radius:999px;cursor:pointer;font-weight:bold}
button.active,button:hover{background:var(--accent);border-color:var(--accent);color:#10172b}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(230px,1fr));gap:16px}
.card{background:var(--panel);border:1px solid var(--line);border-radius:16px;padding:21px;box-shadow:0 12px 30px #0003}
.card h2{font-size:1.15rem;margin:5px 0}
.semester{font-size:.78rem;color:#aab7ff;font-weight:bold;text-transform:uppercase;letter-spacing:1px}
.card p{font-size:.9rem;margin:6px 0 18px}
.links{display:grid;gap:9px}
a{display:block;text-decoration:none;color:#dce3ff;border:1px solid #405078;padding:9px 12px;border-radius:9px;font-size:.9rem}
a:hover{background:#273653;border-color:var(--accent)}
footer{text-align:center;color:var(--muted);font-size:.82rem;margin-top:34px}
[hidden]{display:none!important}
</style>
</head>
<body>
<main>
<header>
<div class="tag">Your study space</div>
<h1>Class Notes Hub</h1>
<p>Welcome! Find your lecture notes, revise at your own pace, and keep learning.</p>
</header>
<nav class="filters" aria-label="Filter notes by semester">
<button class="active" data-filter="all" aria-pressed="true">All Notes</button>
<button data-filter="1" aria-pressed="false">Semester 1</button>
<button data-filter="2" aria-pressed="false">Semester 2</button>
</nav>
<section class="grid" aria-label="Lecture note units">
<article class="card" data-semester="1">
<div class="semester">Semester 1</div>
<h2>Introduction to Programming</h2>
<p>Programming concepts, algorithms and data types.</p>
<div class="links">
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-1-Notes.pdf" target="_blank" rel="noopener">View lecture notes ↗</a>
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-1-Notes.pdf" download>Download lecture notes ↓</a>
</div>
</article>
<article class="card" data-semester="1">
<div class="semester">Semester 1</div>
<h2>Calculus I</h2>
<p>Functions, function notation and introductory limits.</p>
<div class="links">
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-2-Notes.pdf" target="_blank" rel="noopener">View lecture notes ↗</a>
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-2-Notes.pdf" download>Download lecture notes ↓</a>
</div>
</article>
<article class="card" data-semester="2">
<div class="semester">Semester 2</div>
<h2>Computer Networks</h2>
<p>Network types, devices, IP addresses and safety.</p>
<div class="links">
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-3-Notes.pdf" target="_blank" rel="noopener">View lecture notes ↗</a>
<a href="https://note-hub-weston-01.s3.eu-north-1.amazonaws.com/public/Week-3-Notes.pdf" download>Download lecture notes ↓</a>
</div>
</article>
</section>
<footer>Class Notes Hub · Learn something new every day.</footer>
</main>
<script>
const buttons=document.querySelectorAll("[data-filter]");
const cards=document.querySelectorAll(".card");
buttons.forEach(button=>button.addEventListener("click",()=>{
  const filter=button.dataset.filter;
  buttons.forEach(item=>{
    const selected=item===button;
    item.classList.toggle("active",selected);
    item.setAttribute("aria-pressed",String(selected));
  });
  cards.forEach(card=>card.hidden=filter!=="all"&&card.dataset.semester!==filter);
}));
</script>
</body>
</html>
EOF
