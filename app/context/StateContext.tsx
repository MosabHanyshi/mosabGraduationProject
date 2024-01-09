"use client"// StateContext.tsx
import React, {
  createContext,
  useContext,
  useState,
  ReactNode,
  Dispatch,
  SetStateAction,
} from "react";

interface StateContextProps {
  count: number;
  setCount: Dispatch<SetStateAction<number>>;
}

interface StateProviderProps {
  children: ReactNode;
}

const StateContext = createContext<StateContextProps | undefined>(undefined);

export const StateProvider: React.FC<StateProviderProps> = ({ children }) => {
  const [count, setCount] = useState<number>(0);

  return (
    <StateContext.Provider value={{ count, setCount }}>
      {children}
    </StateContext.Provider>
  );
};

export const useStateValue = () => {
  const context = useContext(StateContext);
  if (!context) {
    throw new Error("useStateValue must be used within a StateProvider");
  }
  return context;
};
