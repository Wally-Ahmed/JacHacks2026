"""Countdown timer — Winter 2026."""

cl import from .components.countdownApp { CountdownApp }
cl import ".styles.global.css";

cl {
    def:pub app() -> JsxElement {
        return <CountdownApp />;
    }
}
