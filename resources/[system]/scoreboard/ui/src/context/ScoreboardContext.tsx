import { useContext, createContext, useState } from 'react';
import { useNuiEvent } from "../utils/useNuiEvent";

export const ScoreboardContext = createContext<Context | undefined>(undefined);

export const ScoreboardProvider = ({ children }: { children: React.ReactNode }) => {
	const [visibility, setVisibility] = useState<boolean>(false);
	const [data, setData] = useState(null);
	const [players, setPlayers] = useState(null);

	useNuiEvent('CfxScoreboard', 'setVisibility', setVisibility);
	useNuiEvent('CfxScoreboard', 'setData', setData);
	useNuiEvent('CfxScoreboard', 'setPlayers', setPlayers)

	const value = {
		visibility,
		setVisibility,
		data,
		setData,
		players,
		setPlayers
	}

	return <ScoreboardContext.Provider value={value}>{children}</ScoreboardContext.Provider>
}

interface Context {
	visibility: boolean;
	setVisibility: (show: boolean) => void;
	data: any[];
	setData: (show: boolean) => void;
	players: any[];
	setPlayers: (players: any) => void;
}

export const useScoreboard = () => {
	const { visibility, setVisibility } = useContext(ScoreboardContext);
	return { visibility, setVisibility };
}

export const useData = () => {
	const { data, setData } = useContext(ScoreboardContext);
	return { data, setData };
}