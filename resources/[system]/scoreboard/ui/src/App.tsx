import React from 'react';
import logo from './logo.svg';
import './App.css';
import Scoreboard from "./Scoreboard";
import { useScoreboard } from "./context/ScoreboardContext";

function App() {
  setTimeout(() => {
    window.dispatchEvent(
      new MessageEvent('message', {
        data: {
          app: 'CfxScoreboard',
          method: 'setData',
          data: [
            {
              type: 'column',
              data: {

              }
            }
          ]
        }
      })
    )
  }, 1000)

  const { visibility } = useScoreboard();
  return (
    <div>
      {visibility ? <Scoreboard /> : null}
    </div>
  );
}

export default App;
