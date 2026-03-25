<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ORANGE-FRESH · EIS Presentation</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',sans-serif;background:#0f1c22;color:#fff;height:100vh;overflow:hidden;display:flex;flex-direction:column}
#app{width:100%;flex:1;display:flex;flex-direction:column;max-width:1100px;margin:0 auto;padding:16px 16px 0}
#slide-area{flex:1;position:relative;overflow:hidden}
.slide{position:absolute;inset:0;padding:36px 48px 24px;opacity:0;transform:translateX(70px);transition:all .38s cubic-bezier(.4,0,.2,1);pointer-events:none;display:flex;flex-direction:column}
.slide.active{opacity:1;transform:translateX(0);pointer-events:all}
.slide.exit{opacity:0;transform:translateX(-70px)}
#nav{display:flex;align-items:center;justify-content:space-between;padding:10px 16px;background:#0a1519;border-top:1px solid rgba(255,255,255,.07);flex-shrink:0}
.nav-btn{background:none;border:1px solid rgba(255,255,255,.2);color:#fff;border-radius:8px;padding:7px 20px;cursor:pointer;font-size:13px;transition:all .18s;font-family:inherit}
.nav-btn:hover{background:rgba(255,255,255,.1)}
.nav-btn:disabled{opacity:.28;cursor:not-allowed}
#slide-dots{display:flex;gap:7px;align-items:center}
.dot{width:8px;height:8px;border-radius:50%;background:rgba(255,255,255,.22);cursor:pointer;transition:all .2s;border:none}
.dot.active{background:#e87722;transform:scale(1.35)}
#slide-counter{color:rgba(255,255,255,.35);font-size:12px;min-width:44px;text-align:right}
.tag{font-size:11px;letter-spacing:.09em;color:#e87722;font-weight:600;text-transform:uppercase;margin-bottom:8px}
.slide-title{font-size:28px;font-weight:600;color:#fff;line-height:1.15;margin-bottom:6px}
.orange-bar{width:44px;height:3px;background:#e87722;border-radius:2px;margin-bottom:18px}
.card{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:16px}
.agenda-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;flex:1}
.ag-item{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.09);border-radius:10px;padding:12px 14px;display:flex;gap:12px;align-items:flex-start}
.ag-num{width:32px;height:32px;border-radius:8px;background:#0d6e6e;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:600;color:#fff;flex-shrink:0}
.ag-title{font-size:13px;font-weight:600;color:#fff;margin-bottom:3px}
.ag-sub{font-size:11.5px;color:rgba(255,255,255,.42)}
.stat-row{display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px;margin-bottom:14px}
.stat-card{background:#1e3440;border-radius:12px;padding:14px;text-align:center;border-top:3px solid #e87722}
.stat-val{font-size:28px;font-weight:600;color:#f5a540;margin-bottom:4px}
.stat-lbl{font-size:11px;color:rgba(255,255,255,.42);line-height:1.4}
.gap-box{background:rgba(13,110,110,.14);border:1px solid rgba(13,110,110,.38);border-radius:10px;padding:13px 16px;margin-bottom:10px}
.gap-box p{font-size:13px;color:rgba(255,255,255,.72);line-height:1.55}
.solution-pill{display:inline-flex;align-items:center;gap:6px;background:#e87722;border-radius:8px;padding:8px 18px;font-size:13px;font-weight:600;color:#fff}
.principle-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;flex:1}
.p-left{display:flex;flex-direction:column;gap:10px}
.p-item{display:flex;gap:10px;align-items:flex-start}
.p-num{width:26px;height:26px;border-radius:50%;background:#0d6e6e;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:600;color:#fff;flex-shrink:0;margin-top:1px}
.p-content h4{font-size:12.5px;font-weight:600;color:#12908f;margin-bottom:3px}
.p-content p{font-size:12px;color:rgba(255,255,255,.58);line-height:1.5}
.p-right{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:14px;display:flex;flex-direction:column;align-items:center}
.p-right h4{font-size:12px;font-weight:600;color:#12908f;margin-bottom:10px;text-align:center}
canvas{display:block}
.sim-metric{background:#1e3440;border-radius:8px;padding:9px;text-align:center}
.sim-metric .val{font-size:18px;font-weight:600;color:#f5a540}
.sim-metric .lbl{font-size:10px;color:rgba(255,255,255,.38);margin-top:2px}
.hw-block{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);border-radius:10px;padding:12px 14px;display:flex;gap:12px;align-items:flex-start}
.hw-icon{width:36px;height:36px;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0}
.hw-block h3{font-size:13px;font-weight:600;margin-bottom:3px}
.hw-block p{font-size:12px;color:rgba(255,255,255,.48);line-height:1.45}
.hw-arrow{text-align:center;color:#e87722;font-size:14px;line-height:1.2}
.wf-step{background:#1e3440;border-radius:10px;padding:10px 12px;display:flex;gap:10px;align-items:center}
.wf-num{width:24px;height:24px;border-radius:50%;background:#e87722;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:600;color:#fff;flex-shrink:0}
.wf-text{font-size:12px;color:rgba(255,255,255,.68);line-height:1.4}
.out-card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:14px;position:relative;overflow:hidden}
.out-card::before{content:'';position:absolute;top:0;left:0;right:0;height:3px}
.out-card.teal::before{background:#0d6e6e}
.out-card.orange::before{background:#e87722}
.out-card.light::before{background:#12908f}
.out-card.brown::before{background:#8a5a2a}
.out-card h3{font-size:12.5px;font-weight:600;color:rgba(255,255,255,.55);margin-bottom:4px}
.out-val{font-size:20px;font-weight:600;margin-bottom:4px}
.out-note{font-size:11px;color:rgba(255,255,255,.38);font-style:italic}
.specs-bar{display:grid;grid-template-columns:repeat(5,1fr);background:#0a1519;border-radius:10px;padding:10px 0;margin-top:10px;border:1px solid rgba(255,255,255,.06)}
.spec-item{text-align:center;padding:0 8px;border-right:1px solid rgba(255,255,255,.06)}
.spec-item:last-child{border-right:none}
.spec-val{font-size:13px;font-weight:600;color:#f5a540;margin-bottom:2px}
.spec-lbl{font-size:10px;color:rgba(255,255,255,.33)}
.val-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:10px;flex:1}
.val-card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:14px}
.val-card h3{font-size:13px;font-weight:600;margin-bottom:6px}
.stage-label{font-size:11px;font-weight:600;border-radius:6px;padding:3px 8px;display:inline-block;margin-bottom:8px}
.val-item{font-size:12px;color:rgba(255,255,255,.58);padding:4px 0 4px 14px;position:relative;line-height:1.4}
.val-item::before{content:'·';position:absolute;left:4px;color:#e87722}
.bench-table{width:100%;border-collapse:collapse;font-size:12px}
.bench-table th{background:#1e3440;color:rgba(255,255,255,.55);font-weight:600;padding:8px 10px;text-align:left;font-size:11.5px}
.bench-table td{padding:8px 10px;border-bottom:1px solid rgba(255,255,255,.06);color:rgba(255,255,255,.68);line-height:1.4;vertical-align:top}
.bench-table tr:last-child td{color:#5dd3c8;font-weight:600;background:rgba(13,110,110,.1);border-bottom:none}
.badge{display:inline-block;font-size:10px;padding:2px 7px;border-radius:5px;font-weight:600}
.badge-teal{background:rgba(13,110,110,.3);color:#5dd3c8}
.badge-orange{background:rgba(232,119,34,.2);color:#f5a540}
.badge-gray{background:rgba(255,255,255,.1);color:rgba(255,255,255,.48)}
.feas-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;flex:1}
.feas-card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.1);border-radius:12px;padding:14px}
.feas-card .icon{width:32px;height:32px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:15px;margin-bottom:10px}
.feas-card h3{font-size:13px;font-weight:600;margin-bottom:6px}
.feas-card p{font-size:12px;color:rgba(255,255,255,.52);line-height:1.5}
.summary-item{display:flex;gap:10px;align-items:center;background:rgba(255,255,255,.05);border-radius:10px;padding:10px 14px}
.summary-dot{width:8px;height:8px;border-radius:50%;background:#e87722;flex-shrink:0}
.summary-item span{font-size:13px;color:rgba(255,255,255,.72)}
.deco{position:absolute;border-radius:50%;pointer-events:none}
input[type=range]{width:100%;accent-color:#e87722;cursor:pointer}
</style>
</head>
<body>
<div id="app">
  <div id="slide-area">

    <!-- S0: TITLE -->
    <div class="slide active" id="s0">
      <div class="deco" style="width:260px;height:260px;background:rgba(232,119,34,.1);right:-60px;top:-80px"></div>
      <div class="deco" style="width:140px;height:140px;background:rgba(232,119,34,.07);right:80px;top:-10px"></div>
      <div style="font-size:11px;color:rgba(255,255,255,.3);letter-spacing:.07em;text-transform:uppercase;margin-bottom:40px">EMST Group Project · Spring Semester · Master's in Electronic Engineering</div>
      <div style="flex:1;display:flex;flex-direction:column;justify-content:center">
        <div style="font-size:42px;font-weight:700;color:#fff;line-height:1.1;margin-bottom:10px">Orange Freshness &<br>Ripeness Classification</div>
        <div style="font-size:17px;color:#f5a540;margin-bottom:22px">Using Electrical Impedance Spectroscopy (EIS)</div>
        <div class="orange-bar"></div>
        <div style="font-size:13px;color:rgba(255,255,255,.38);margin-bottom:22px">Shahan Antabian · Borja Aguilar Garcia · Pol Santana Fajardo · Sergi López Pajuelo</div>
        <span style="display:inline-flex;align-items:center;background:#0d6e6e;border-radius:8px;padding:7px 14px;font-size:12px;font-weight:600;color:#fff;width:fit-content">ORANGE-FRESH</span>
      </div>
    </div>

    <!-- S1: AGENDA -->
    <div class="slide" id="s1">
      <div class="tag">Overview</div>
      <div class="slide-title">Presentation Structure</div>
      <div class="orange-bar"></div>
      <div class="agenda-grid">
        <div class="ag-item"><div class="ag-num">01</div><div><div class="ag-title">Problem & Measurement Need</div><div class="ag-sub">Why current methods fall short</div></div></div>
        <div class="ag-item"><div class="ag-num" style="background:#e87722">02</div><div><div class="ag-title">Scientific Principle (EIS)</div><div class="ag-sub">Impedance physics in fruit tissue</div></div></div>
        <div class="ag-item"><div class="ag-num">03</div><div><div class="ag-title">System Design</div><div class="ag-sub">Hardware architecture & workflow</div></div></div>
        <div class="ag-item"><div class="ag-num" style="background:#e87722">04</div><div><div class="ag-title">Output Variables & Specs</div><div class="ag-sub">What the device displays</div></div></div>
        <div class="ag-item"><div class="ag-num">05</div><div><div class="ag-title">Validation Strategy</div><div class="ag-sub">From phantoms to real oranges</div></div></div>
        <div class="ag-item"><div class="ag-num" style="background:#e87722">06</div><div><div class="ag-title">Feasibility & Impact</div><div class="ag-sub">Why this project works</div></div></div>
      </div>
    </div>

    <!-- S2: PROBLEM -->
    <div class="slide" id="s2">
      <div class="tag">01 — Problem</div>
      <div class="slide-title">The Measurement Gap in Post-Harvest Citrus</div>
      <div class="orange-bar"></div>
      <div class="stat-row">
        <div class="stat-card"><div class="stat-val">Slow</div><div class="stat-lbl">Manual inspection<br>limits throughput</div></div>
        <div class="stat-card"><div class="stat-val">Costly</div><div class="stat-lbl">Destructive lab tests<br>consume samples</div></div>
        <div class="stat-card"><div class="stat-val">Partial</div><div class="stat-lbl">Peel colour misses<br>internal quality</div></div>
      </div>
      <div class="gap-box"><p>Packhouses, research labs and small producers need a compact, fast, non-destructive instrument to screen fruit quality — without cutting oranges open.</p></div>
      <div><span class="solution-pill">→ EIS fills this gap &nbsp;·&nbsp; Portable · Non-destructive · &lt;10 s/fruit</span></div>
    </div>

    <!-- S3: EIS PRINCIPLE -->
    <div class="slide" id="s3">
      <div class="tag">02 — Scientific Principle</div>
      <div class="slide-title">EIS in Fruit Tissue</div>
      <div class="orange-bar"></div>
      <div class="principle-grid">
        <div class="p-left">
          <div class="p-item"><div class="p-num">1</div><div class="p-content"><h4>What EIS measures</h4><p>Complex impedance Z(f) swept over frequency — magnitude |Z| and phase angle θ at each point.</p></div></div>
          <div class="p-item"><div class="p-num">2</div><div class="p-content"><h4>Why tissue changes</h4><p>Ripening alters membrane integrity, moisture & ionic conductivity → measurable shifts in |Z| and θ.</p></div></div>
          <div class="p-item"><div class="p-num">3</div><div class="p-content"><h4>Literature basis</h4><p>Mandarin EIS 50 Hz–1 MHz shows clear ripening-dependent spectral changes (Chowdhury et al. 2017).</p></div></div>
          <div class="p-item"><div class="p-num">4</div><div class="p-content"><h4>Our target range</h4><p>100 Hz – 1 MHz · 20–50 points · 200–500 mV peak excitation</p></div></div>
        </div>
        <div class="p-right">
          <h4>Live Nyquist Plot — drag to age the orange</h4>
          <canvas id="nyquist-canvas" width="230" height="165"></canvas>
          <div style="width:100%;margin-top:8px">
            <label style="font-size:11.5px;color:rgba(255,255,255,.45)">Storage days: <span id="days-val" style="color:#f5a540;font-weight:600">0</span></label>
            <input type="range" min="0" max="21" step="1" value="0" id="days-slider" style="margin-top:4px">
          </div>
          <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:6px;width:100%;margin-top:8px">
            <div class="sim-metric"><div class="val" id="z-val">48</div><div class="lbl">|Z| kΩ @ 1kHz</div></div>
            <div class="sim-metric"><div class="val" id="phase-val">-18°</div><div class="lbl">Phase @ 1kHz</div></div>
            <div class="sim-metric"><div class="val" id="fi-val">100</div><div class="lbl">Freshness index</div></div>
          </div>
        </div>
      </div>
    </div>

    <!-- S4: SYSTEM DESIGN -->
    <div class="slide" id="s4">
      <div class="tag">03 — System Design</div>
      <div class="slide-title">Hardware & User Workflow</div>
      <div class="orange-bar"></div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;flex:1">
        <div style="display:flex;flex-direction:column;gap:8px">
          <div class="hw-block"><div class="hw-icon" style="background:rgba(232,119,34,.18)">🔌</div><div><h3 style="color:#f5a540">Clamp + Electrodes</h3><p>Spring-loaded SS/Ag-AgCl contacts. Controls spacing & contact pressure. Non-destructive.</p></div></div>
          <div class="hw-arrow">↓</div>
          <div class="hw-block"><div class="hw-icon" style="background:rgba(13,110,110,.2)">📡</div><div><h3 style="color:#12908f">Analog Front-End</h3><p>DDS excitation 100 Hz–1 MHz, 200–500 mV. Current/voltage sensing + calibration network.</p></div></div>
          <div class="hw-arrow">↓</div>
          <div class="hw-block"><div class="hw-icon" style="background:rgba(18,144,143,.2)">💾</div><div><h3 style="color:#5dd3c8">Microcontroller</h3><p>Freq. sweep · Feature extraction · Temp. compensation · USB/Bluetooth output.</p></div></div>
        </div>
        <div style="display:flex;flex-direction:column;gap:8px">
          <div style="font-size:12px;font-weight:600;color:#f5a540;margin-bottom:2px">Typical user workflow</div>
          <div class="wf-step"><div class="wf-num">1</div><div class="wf-text">Daily calibration — open / short / reference RC</div></div>
          <div class="wf-step"><div class="wf-num">2</div><div class="wf-text">Place orange in the clamp</div></div>
          <div class="wf-step"><div class="wf-num">3</div><div class="wf-text">Launch 3–8 s frequency sweep</div></div>
          <div class="wf-step"><div class="wf-num">4</div><div class="wf-text">Read freshness index + ripeness class on screen</div></div>
          <div class="wf-step"><div class="wf-num">5</div><div class="wf-text">Save locally or export CSV to laptop</div></div>
        </div>
      </div>
    </div>

    <!-- S5: OUTPUTS -->
    <div class="slide" id="s5">
      <div class="tag">04 — Outputs & Specs</div>
      <div class="slide-title">What the Device Displays</div>
      <div class="orange-bar"></div>
      <div style="display:grid;grid-template-columns:1fr 1fr;gap:10px;flex:1">
        <div class="out-card teal"><h3>Freshness Index</h3><div class="out-val" style="color:#5dd3c8">0 – 100</div><div class="out-note">Monotonically decreases with ageing</div></div>
        <div class="out-card orange"><h3>Ripeness Class</h3><div class="out-val" style="color:#f5a540">Unripe / Ready / Overripe</div><div class="out-note">3-class classifier output</div></div>
        <div class="out-card light"><h3>Storage-Age Class</h3><div class="out-val" style="color:#12908f">0 / 7 / 14 / 21 days</div><div class="out-note">Discrete post-harvest age estimate</div></div>
        <div class="out-card brown"><h3>Quality Flag</h3><div class="out-val" style="color:#f5a540">OK / Re-measure</div><div class="out-note">Bad contact or out-of-range warning</div></div>
      </div>
      <div class="specs-bar">
        <div class="spec-item"><div class="spec-val">&lt;10 s</div><div class="spec-lbl">per fruit</div></div>
        <div class="spec-item"><div class="spec-val">&lt;5%</div><div class="spec-lbl">repeatability</div></div>
        <div class="spec-item"><div class="spec-val">&gt;80%</div><div class="spec-lbl">accuracy</div></div>
        <div class="spec-item"><div class="spec-val">100Hz–1MHz</div><div class="spec-lbl">freq. range</div></div>
        <div class="spec-item"><div class="spec-val">USB/Bat.</div><div class="spec-lbl">power</div></div>
      </div>
    </div>

    <!-- S6: VALIDATION -->
    <div class="slide" id="s6">
      <div class="tag">05 — Validation</div>
      <div class="slide-title">Three-Stage Validation Strategy</div>
      <div class="orange-bar"></div>
      <div class="val-grid">
        <div class="val-card" style="border-top:3px solid #0d6e6e">
          <span class="stage-label" style="background:rgba(13,110,110,.22);color:#5dd3c8">Stage 1</span>
          <h3 style="color:#5dd3c8">Electrical References</h3>
          <div class="val-item">RC & R-CPE reference networks</div>
          <div class="val-item">Quantify freq. response & repeatability</div>
          <div class="val-item">Validate calibration quality</div>
        </div>
        <div class="val-card" style="border-top:3px solid #e87722">
          <span class="stage-label" style="background:rgba(232,119,34,.18);color:#f5a540">Stage 2</span>
          <h3 style="color:#f5a540">Saline/Agar Phantoms</h3>
          <div class="val-item">Phantom in spherical mould</div>
          <div class="val-item">Orange-like dimensions</div>
          <div class="val-item">Controlled conductivity variation</div>
        </div>
        <div class="val-card" style="border-top:3px solid #12908f">
          <span class="stage-label" style="background:rgba(18,144,143,.18);color:#12908f">Stage 3</span>
          <h3 style="color:#12908f">Real Oranges (if feasible)</h3>
          <div class="val-item">0, 7, 14, 21 days stored</div>
          <div class="val-item">Paired: weight loss, firmness, pH</div>
          <div class="val-item">Build classifiers & calib. curves</div>
        </div>
      </div>
      <div style="background:rgba(13,110,110,.1);border:1px solid rgba(13,110,110,.28);border-radius:8px;padding:10px 14px;margin-top:10px;font-size:12px;color:rgba(255,255,255,.58);font-style:italic">
        Project does not depend exclusively on biological samples — electrical stages are self-sufficient for grading.
      </div>
    </div>

    <!-- S7: BENCHMARKING -->
    <div class="slide" id="s7">
      <div class="tag">Market Context</div>
      <div class="slide-title">Benchmarking Against Existing Methods</div>
      <div class="orange-bar"></div>
      <table class="bench-table">
        <thead><tr><th>Method</th><th>Advantages</th><th>Limitations</th><th>vs. EIS</th></tr></thead>
        <tbody>
          <tr><td>Destructive lab<br><span style="color:rgba(255,255,255,.35);font-size:11px">(Brix/TA, pH)</span></td><td>High interpretability<br>Established practice</td><td>Slow, sample-consuming<br>Not scalable</td><td><span class="badge badge-gray">Ground truth</span></td></tr>
          <tr><td>Colour / Machine Vision</td><td>Fast, cheap cameras<br>Inline-compatible</td><td>Mostly external<br>Misses internal quality</td><td><span class="badge badge-gray">Complement</span></td></tr>
          <tr><td>Vis/NIR Spectroscopy</td><td>Strong literature base<br>Handheld options</td><td>Higher cost<br>Peel/rind effects</td><td><span class="badge badge-orange">Main alternative</span></td></tr>
          <tr><td><strong>EIS (ours)</strong></td><td>Portable, low-cost<br>Fast &lt;10 s, internal sensing</td><td>Needs calibration<br>Contact variability</td><td><span class="badge badge-teal">Target solution</span></td></tr>
        </tbody>
      </table>
    </div>

    <!-- S8: FEASIBILITY -->
    <div class="slide" id="s8">
      <div class="tag">06 — Feasibility</div>
      <div class="slide-title">Why This Project Works</div>
      <div class="orange-bar"></div>
      <div class="feas-grid">
        <div class="feas-card"><div class="icon" style="background:rgba(13,110,110,.22)">⚙️</div><h3 style="color:#5dd3c8">Manageable hardware</h3><p>Impedance front-end + MCU. No advanced optics or robotics. Feasible within course scope.</p></div>
        <div class="feas-card"><div class="icon" style="background:rgba(232,119,34,.18)">🧪</div><h3 style="color:#f5a540">Safe test strategy</h3><p>Staged: references → phantoms → real oranges. Not dependent on full biological experimentation.</p></div>
        <div class="feas-card"><div class="icon" style="background:rgba(18,144,143,.18)">📊</div><h3 style="color:#12908f">Proof-of-concept value</h3><p>Even coarse classification proves EIS is viable for post-harvest fruit quality screening.</p></div>
        <div class="feas-card"><div class="icon" style="background:rgba(245,165,64,.13)">🚀</div><h3 style="color:#f5a540">Future-proof platform</h3><p>Upgrade path: 4-electrode, sensor fusion with vision/temperature, ML-based classification.</p></div>
      </div>
    </div>

    <!-- S9: CLOSING -->
    <div class="slide" id="s9">
      <div class="deco" style="width:240px;height:240px;background:rgba(232,119,34,.09);right:-40px;top:10px"></div>
      <div style="font-size:46px;font-weight:700;color:#fff;margin-bottom:10px">Thank you</div>
      <div style="font-size:15px;color:#f5a540;margin-bottom:16px">Orange Freshness & Ripeness Classification via EIS</div>
      <div class="orange-bar"></div>
      <div style="display:flex;flex-direction:column;gap:10px;flex:1;justify-content:center">
        <div class="summary-item"><div class="summary-dot"></div><span>Non-destructive EIS at 100 Hz – 1 MHz, under 10 s per fruit</span></div>
        <div class="summary-item"><div class="summary-dot"></div><span>3-stage validation: RC references → phantoms → real oranges</span></div>
        <div class="summary-item"><div class="summary-dot"></div><span>Outputs: freshness index · ripeness class · storage age estimate</span></div>
        <div class="summary-item"><div class="summary-dot"></div><span>Portable, low-cost, USB/battery powered</span></div>
      </div>
      <div style="font-size:24px;font-weight:600;color:#f5a540;margin-top:16px">Questions?</div>
      <div style="font-size:12px;color:rgba(255,255,255,.28);margin-top:8px">Antabian · Aguilar Garcia · Santana Fajardo · López Pajuelo</div>
    </div>

  </div>

  <div id="nav">
    <button class="nav-btn" id="prev-btn" onclick="go(cur-1)" disabled>← Prev</button>
    <div id="slide-dots"></div>
    <div style="display:flex;align-items:center;gap:12px">
      <div id="slide-counter">1 / 10</div>
      <button class="nav-btn" id="next-btn" onclick="go(cur+1)">Next →</button>
    </div>
  </div>
</div>

<script>
const TOTAL=10;let cur=0;
const slides=Array.from(document.querySelectorAll('.slide'));
const dotsEl=document.getElementById('slide-dots');
const prevBtn=document.getElementById('prev-btn');
const nextBtn=document.getElementById('next-btn');
const counter=document.getElementById('slide-counter');
slides.forEach((_,i)=>{const d=document.createElement('button');d.className='dot'+(i===0?' active':'');d.onclick=()=>go(i);dotsEl.appendChild(d);});
function go(n){if(n<0||n>=TOTAL)return;slides[cur].classList.remove('active');slides[cur].classList.add('exit');setTimeout(()=>slides[cur].classList.remove('exit'),400);cur=n;slides[cur].classList.add('active');document.querySelectorAll('.dot').forEach((d,i)=>d.classList.toggle('active',i===cur));counter.textContent=(cur+1)+' / '+TOTAL;prevBtn.disabled=cur===0;nextBtn.disabled=cur===TOTAL-1;if(cur===3)setTimeout(initNyquist,150);}
document.addEventListener('keydown',e=>{if(e.key==='ArrowRight')go(cur+1);if(e.key==='ArrowLeft')go(cur-1);});
function initNyquist(){const canvas=document.getElementById('nyquist-canvas');if(!canvas||canvas._init)return;canvas._init=true;const ctx=canvas.getContext('2d');const slider=document.getElementById('days-slider');function draw(days){const Re=8+days*0.8,Ri=40+days*3.5,Cm=1e-6*(1-days*0.025);const freqs=[];for(let i=0;i<=60;i++)freqs.push(100*Math.pow(10000,i/60));const pts=freqs.map(f=>{const w=2*Math.PI*f,wC=w*Cm*Ri,d2=1+wC*wC;return{x:Re+Ri/d2,y:Ri*wC/d2};});const allX=pts.map(p=>p.x),allY=pts.map(p=>p.y);const minX=Math.min(...allX),maxX=Math.max(...allX),maxY=Math.max(...allY)*1.18;const W=canvas.width,H=canvas.height,pl=32,pr=10,pt=10,pb=28;const sx=x=>(x-minX)/(maxX-minX||1)*(W-pl-pr)+pl;const sy=y=>H-pb-(y)/(maxY||1)*(H-pt-pb);ctx.clearRect(0,0,W,H);ctx.strokeStyle='rgba(255,255,255,.12)';ctx.lineWidth=1;ctx.beginPath();ctx.moveTo(pl,pt);ctx.lineTo(pl,H-pb);ctx.lineTo(W-pr,H-pb);ctx.stroke();ctx.fillStyle='rgba(255,255,255,.3)';ctx.font='10px sans-serif';ctx.textAlign='center';ctx.fillText("Z' (kΩ)",W/2,H-4);ctx.save();ctx.translate(10,H/2);ctx.rotate(-Math.PI/2);ctx.fillText("-Z''",0,0);ctx.restore();if(days>0){const g0=freqs.map(f=>{const w=2*Math.PI*f,wC=w*1e-6*40,d2=1+wC*wC;return{x:8+40/d2,y:40*wC/d2};});ctx.strokeStyle='rgba(93,211,200,.2)';ctx.lineWidth=1.5;ctx.setLineDash([4,4]);ctx.beginPath();g0.forEach((p,i)=>i?ctx.lineTo(sx(p.x),sy(p.y)):ctx.moveTo(sx(p.x),sy(p.y)));ctx.stroke();ctx.setLineDash([]);}const g=ctx.createLinearGradient(sx(pts[0].x),0,sx(pts[pts.length-1].x),0);g.addColorStop(0,'#5dd3c8');g.addColorStop(1,'#e87722');ctx.strokeStyle=g;ctx.lineWidth=2.5;ctx.beginPath();pts.forEach((p,i)=>i?ctx.lineTo(sx(p.x),sy(p.y)):ctx.moveTo(sx(p.x),sy(p.y)));ctx.stroke();const m=pts[Math.floor(pts.length/2)];ctx.fillStyle='#e87722';ctx.beginPath();ctx.arc(sx(m.x),sy(m.y),4,0,2*Math.PI);ctx.fill();const w1=2*Math.PI*1000,wC1=w1*Cm*Ri,d1=1+wC1*wC1,Zr1=Re+Ri/d1,Zi1=Ri*wC1/d1;document.getElementById('z-val').textContent=Math.sqrt(Zr1*Zr1+Zi1*Zi1).toFixed(0);document.getElementById('phase-val').textContent=(-Math.atan2(Zi1,Zr1)*180/Math.PI).toFixed(0)+'°';document.getElementById('fi-val').textContent=Math.max(0,Math.round(100-days*4.2));document.getElementById('days-val').textContent=days;}
slider.addEventListener('input',()=>draw(+slider.value));draw(0);}
</script>
</body>
</html>
