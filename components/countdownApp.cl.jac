"""Countdown timer component — circular dot-ring style."""

def:pub CountdownApp() -> JsxElement {
    has target_year: int = 2026;
    has target_month: int = 12;
    has target_day: int = 31;
    has editing: bool = False;
    has days: int = 0;
    has hours: int = 0;
    has minutes: int = 0;
    has seconds: int = 0;
    
    can with [target_year, target_month, target_day] entry {
        def tick() -> None {
            mo = str(target_month) if target_month >= 10 else "0" + str(target_month);
            dy = str(target_day) if target_day >= 10 else "0" + str(target_day);
            target = Date.parse(str(target_year) + "-" + mo + "-" + dy + "T00:00:00");
            diff = target - Date.now();
            if diff > 0 {
                days = Math.floor(diff / 86400000);
                hours = Math.floor((diff % 86400000) / 3600000);
                minutes = Math.floor((diff % 3600000) / 60000);
                seconds = Math.floor((diff % 60000) / 1000);
            } else {
                days = 0;
                hours = 0;
                minutes = 0;
                seconds = 0;
            }
        }
        tick();
        id = setInterval(tick, 1000);

        def cleanup() -> None {
            clearInterval(id);
        }

        return cleanup;
    }

    circ: float = 477.52;
    days_arc: str = str(days / 365.0 * circ) + " " + str(circ);
    hours_arc: str = str(hours / 24.0 * circ) + " " + str(circ);
    minutes_arc: str = str(minutes / 60.0 * circ) + " " + str(circ);
    seconds_arc: str = str(seconds / 60.0 * circ) + " " + str(circ);

    def pad2(n: int) -> str {
        s = str(n);
        if len(s) < 2 {
            return "0" + s;
        }
        return s;
    }

    def dec_year() -> None {
        target_year = target_year - 1;
    }

    def inc_year() -> None {
        target_year = target_year + 1;
    }

    def dec_month() -> None {
        target_month = target_month - 1 if target_month > 1 else 12;
    }

    def inc_month() -> None {
        target_month = target_month + 1 if target_month < 12 else 1;
    }

    def dec_day() -> None {
        target_day = target_day - 1 if target_day > 1 else 31;
    }

    def inc_day() -> None {
        target_day = target_day + 1 if target_day < 31 else 1;
    }

    def start_editing() -> None {
        editing = True;
    }

    def stop_editing() -> None {
        editing = False;
    }

    def particle_for(pid: int) -> dict {
        size: int = 12 + ((pid * 23) % 79);
        left_pct: int = 3 + ((pid * 31) % 91);
        top_pct: int = 8 + ((pid * 47) % 83);

        delay_halves: int = (pid * 3) % 13;  # 0..6.0 in 0.5 steps
        delay_s: float = delay_halves / 2.0;
        dur_s: float = 8.0 + float((pid * 5) % 10);

        opacity: float = 0.06 + float((pid * 13) % 25) / 100.0;
        blur_px: int = 3 + ((pid * 7) % 23);

        return {
            "id": pid,
            "size": size,
            "left": str(left_pct) + "%",
            "top": str(top_pct) + "%",
            "delay": str(delay_s) + "s",
            "dur": str(dur_s) + "s",
            "opacity": opacity,
            "filter": "blur(" + str(blur_px) + "px)",

        };
    }

    particle_count: int = 18;
    particles: list = [];
    pid: int = 1;
    while pid <= particle_count {
        particles.append(particle_for(pid));
        pid += 1;
    }

    return
        <div
            className="cd-app relative w-screen h-screen flex flex-col overflow-hidden"
        >
            <div className="cd-bokeh absolute inset-0 pointer-events-none z-0">
                {[
                    <div
                        key={p["id"]}
                        className="cd-particle absolute rounded-full"
                        style={{
                            "width": p["size"],
                            "height": p["size"],
                            "left": p["left"],
                            "top": p["top"],
                            "opacity": p["opacity"],
                            "filter": p["filter"],
                            "animationDelay": p["delay"],
                            "animationDuration": p["dur"],

                        }}
                    /> for p in particles
                ]}
            </div>
            <div
                className="cd-content relative z-10 flex flex-col items-center justify-center flex-1 gap-9"
            >
                <div className="cd-title-row flex items-center gap-3.5">
                    <h1 className="cd-title">
                        COUNTDOWN TIMER
                    </h1>
                </div>
                {editing
                and <div className="cd-editor flex flex-col items-center">
                    <div className="cd-editor-label">
                        TARGET DATE
                    </div>
                    <div className="cd-editor-fields flex items-end gap-[10px]">
                        <div className="cd-field flex flex-col items-center gap-2">
                            <span className="cd-field-label">
                                YEAR
                            </span>
                            <div
                                className="cd-stepper flex items-center overflow-hidden"
                            >
                                <button className="cd-step-btn" onClick={dec_year}>
                                    −
                                </button>
                                <span className="cd-step-val">
                                    {target_year}
                                </span>
                                <button className="cd-step-btn" onClick={inc_year}>
                                    +
                                </button>
                            </div>
                        </div>
                        <div className="cd-field-sep">
                            /
                        </div>
                        <div className="cd-field flex flex-col items-center gap-2">
                            <span className="cd-field-label">
                                MONTH
                            </span>
                            <div
                                className="cd-stepper flex items-center overflow-hidden"
                            >
                                <button className="cd-step-btn" onClick={dec_month}>
                                    −
                                </button>
                                <span className="cd-step-val">
                                    {pad2(target_month)}
                                </span>
                                <button className="cd-step-btn" onClick={inc_month}>
                                    +
                                </button>
                            </div>
                        </div>
                        <div className="cd-field-sep">
                            /
                        </div>
                        <div className="cd-field flex flex-col items-center gap-2">
                            <span className="cd-field-label">
                                DAY
                            </span>
                            <div
                                className="cd-stepper flex items-center overflow-hidden"
                            >
                                <button className="cd-step-btn" onClick={dec_day}>
                                    −
                                </button>
                                <span className="cd-step-val">
                                    {pad2(target_day)}
                                </span>
                                <button className="cd-step-btn" onClick={inc_day}>
                                    +
                                </button>
                            </div>
                        </div>
                    </div>
                    <button className="cd-done-btn" onClick={stop_editing}>
                        DONE
                    </button>
                </div>}
                <div className="cd-timer-block">
                    <div className="cd-rings-row flex items-start gap-9">
                        <div className="cd-ring-item flex flex-col items-center gap-3.5">
                            <div className="cd-ring-wrap relative w-[180px] h-[180px]">
                                <svg viewBox="0 0 180 180" width="180" height="180">
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="rgba(0,180,220,0.15)"
                                        strokeWidth="6"
                                    />
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="#00aaff"
                                        strokeWidth="6"
                                        strokeLinecap="round"
                                        strokeDasharray={days_arc}
                                        transform="rotate(-90 90 90)"
                                    />
                                </svg>
                                <span
                                    className="cd-ring-num absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none"
                                >
                                    {days}
                                </span>
                            </div>
                            <span className="cd-ring-label">
                                DAYS
                            </span>
                        </div>
                        <div className="cd-ring-item flex flex-col items-center gap-3.5">
                            <div className="cd-ring-wrap relative w-[180px] h-[180px]">
                                <svg viewBox="0 0 180 180" width="180" height="180">
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="rgba(0,180,220,0.15)"
                                        strokeWidth="6"
                                    />
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="#00aaff"
                                        strokeWidth="6"
                                        strokeLinecap="round"
                                        strokeDasharray={hours_arc}
                                        transform="rotate(-90 90 90)"
                                    />
                                </svg>
                                <span
                                    className="cd-ring-num absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none"
                                >
                                    {hours}
                                </span>
                            </div>
                            <span className="cd-ring-label">
                                HOURS
                            </span>
                        </div>
                        <div className="cd-ring-item flex flex-col items-center gap-3.5">
                            <div className="cd-ring-wrap relative w-[180px] h-[180px]">
                                <svg viewBox="0 0 180 180" width="180" height="180">
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="rgba(0,180,220,0.15)"
                                        strokeWidth="6"
                                    />
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="#00aaff"
                                        strokeWidth="6"
                                        strokeLinecap="round"
                                        strokeDasharray={minutes_arc}
                                        transform="rotate(-90 90 90)"
                                    />
                                </svg>
                                <span
                                    className="cd-ring-num absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none"
                                >
                                    {minutes}
                                </span>
                            </div>
                            <span className="cd-ring-label">
                                MINUTES
                            </span>
                        </div>
                        <div
                            className="cd-ring-item flex flex-col items-center gap-3.5"
                        >
                            <div className="cd-ring-wrap relative w-[180px] h-[180px]">
                                <svg viewBox="0 0 180 180" width="180" height="180">
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="rgba(0,180,220,0.15)"
                                        strokeWidth="6"
                                    />
                                    <circle
                                        cx="90"
                                        cy="90"
                                        r="76"
                                        fill="none"
                                        stroke="#00aaff"
                                        strokeWidth="6"
                                        strokeLinecap="round"
                                        strokeDasharray={seconds_arc}
                                        transform="rotate(-90 90 90)"
                                    />
                                </svg>
                                <span
                                    className="cd-ring-num absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 pointer-events-none"
                                >
                                    {seconds}
                                </span>
                            </div>
                            <span className="cd-ring-label">
                                SECONDS
                            </span>
                        </div>
                    </div>
                    <div
                        className="btn-wrapper flex justify-center items-center h-[120px]"
                    >
                        <button
                            className="cd-change-btn"
                            type="button"
                            onClick={start_editing}
                        >
                            Change timer
                        </button>
                    </div>
                </div>
            </div>
        </div>;
}
