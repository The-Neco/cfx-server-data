import { useContext, createContext, useState } from 'react';
import { useNuiEvent } from "../utils/useNuiEvent";

export const ScoreboardContext = createContext<Context | undefined>(undefined);

export const ScoreboardProvider = ({ children }: { children: React.ReactNode }) => {
	const [visibility, setVisibility] = useState<boolean>(false);
	const [data, setData] = useState(null);

	useNuiEvent('CfxScoreboard', 'setVisibility', setVisibility);
	useNuiEvent('CfxScoreboard', 'setData', setData);

	const value = {
		visibility,
		setVisibility,
		data,
		setData
	}

	return <ScoreboardContext.Provider value={value}>{children}</ScoreboardContext.Provider>
}

interface Context {
	visibility: boolean;
	setVisibility: (show: boolean) => void;
	data: any[];
	setData: (show: boolean) => void;
}

export const useScoreboard = () => {
	const { visibility, setVisibility } = useContext(ScoreboardContext);
	return { visibility, setVisibility };
}

export const useData = () => {
	const { data, setData } = useContext(ScoreboardContext);
	return { data, setData };
}