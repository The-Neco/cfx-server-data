import React from 'react';
import './App.css';
import Scoreboard from "./Scoreboard";
import { useScoreboard } from "./context/ScoreboardContext";
import { useNuiService } from "./utils/useNuiService";

function App() {
  useNuiService();
  const { visibility } = useScoreboard();

  setTimeout(() => {
    window.dispatchEvent(
      new MessageEvent('message', {
        data: {
          app: 'CfxScoreboard',
          method: 'setVisibility',
          data: true
        }
      })
    )
  }, 1000)
  return (
    <div className="scoreboardWrapper">
      {visibility ? <Scoreboard /> : null}
    </div>
  );
}

export default App;
