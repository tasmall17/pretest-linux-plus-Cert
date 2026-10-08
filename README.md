# Linux+ Readiness Pretest (XK0-006)

A 40-question diagnostic for the **CompTIA Linux+ XK0-006 (V8)** exam. It estimates how many study hours you need
to pass, gives you a target exam date at your weekly pace, and tells you which domains to study first.

## Quick start

```bash
git clone https://github.com/tasmall17/pretest-linux-plus-Cert.git
cd pretest-linux-plus-Cert
./run.sh
```

Your browser opens to the pretest. Press `Ctrl+C` in the terminal when you're done.

**Requirements:** bash, a web browser, and Python 3 (preinstalled on macOS and most Linux distros). Without
Python, `run.sh` opens the page directly as a file, and that works too.

**Windows:** run `./run.sh` from WSL or Git Bash, or just double-click `app/index.html`.

### Options

```
./run.sh --port 9000     # use a different port (default 8765)
./run.sh --no-browser    # start the server and print the URL, e.g. on a headless box
```

## What it covers

Questions are spread across the five exam domains in proportion to the real exam:

| Domain | Exam weight | Questions here |
|---|---|---|
| System Management | 23% | 9 |
| Troubleshooting | 22% | 9 |
| Services & User Management | 20% | 8 |
| Security | 18% | 7 |
| Automation, Orchestration & Scripting | 17% | 7 |

Two questions are ordering tasks, the kind that show up as performance-based questions (PBQs) on the exam. Every
question has an **I don't know** answer. If you can logically narrow the choices down, answer. If you'd be picking
at random, choose I don't know so the estimate stays honest.

## What you get

- Estimated study hours with a likely range, weeks at your pace, and a target exam date
- A rough projected score on CompTIA's 100–900 scale against the 720 passing line
- A score and status for each domain, plus the order to study them in
- A list of the topics you missed and an explanation for every answer
- A copyable text summary (paste it into an AI assistant to get a week-by-week study plan)
- A history of your attempts, so a retake a few weeks later shows how far your estimate has dropped

## How the estimate works

Each domain's score is compared with an 85% target, which leaves a margin above the 720 passing line. A domain you've
mastered still gets 3 hours of review. A domain you score zero on gets its full share of about 150 hours (roughly what
a newcomer needs to learn every objective), split by exam weight. On top of that:

- **Hands-on lab time** of 0–30 hours, based on your Linux experience, because PBQs need terminal fluency that
  multiple-choice questions can't measure
- **12 hours** of practice exams and timed PBQ drills
- An **IT background adjustment** of ×0.9 for admins and developers, ×1.0 for IT support, ×1.15 if you're new to IT

The range runs from 80% to 130% of the estimate. As a sanity check, a complete beginner lands around 220 hours, someone
with a year of hands-on experience around 85, and an experienced admin around 25. Training providers suggest 6–8 weeks
of part-time study with a year of experience and 3–4 months with less.

## About the exam

- Up to 90 questions (multiple choice plus PBQs) in 90 minutes, passing score 720 on a 100–900 scale
- Recommended: about 12 months of hands-on Linux server experience (not required)
- XK0-006 launched July 15, 2025, and XK0-005 retired January 13, 2026. Make sure your study materials cover XK0-006.
- Official objectives: [CompTIA Linux+ certification page](https://www.comptia.org/en-us/certifications/linux/)

## Privacy

Everything runs on your machine. The local server listens only on `127.0.0.1`, and your answers and past attempts are
stored in your browser's local storage. The only network request is for the page's fonts from Google Fonts. Offline,
it falls back to system fonts. Saved progress belongs to the port it ran on, so keep the default port if you want your
history to carry over between runs.

## Disclaimer

The questions are original practice items written to the published XK0-006 domains. They aren't real exam
questions, and this project isn't affiliated with or endorsed by CompTIA. The study-time estimate is a planning aid
based on training-provider benchmarks, not an official figure.
