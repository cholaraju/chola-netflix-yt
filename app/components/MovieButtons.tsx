"use client";

import { Button } from "@/components/ui/button";
import { InfoIcon, PlayCircle } from "lucide-react";
import { useState } from "react";
import PlayVideoModal from "./PlayVideoModal";

interface iAppProps {
  overview: string;
  youtubeUrl: string;
  id: number;
  age: number;
  title: string;
  release: number;
  duration: number;
}

export default function MovieButtons({
  youtubeUrl,
  title,
  overview,
  id,
  age,
  release,
  duration,
}: iAppProps) {
  const [open, setOpen] = useState(false);
  return (
    <>
      <Button onClick={() => setOpen(true)} className="text-lg font-meduim">
        <PlayCircle className="mr-2 w-2 h-6 " /> Play
      </Button>
      <Button
        onClick={() => setOpen(true)}
        className="text-lg font-medium bg-white/40 hover:bg-white/30 text-white"
      >
        <InfoIcon className="mr-2 w-2 h-6 " /> Learn More
      </Button>

      <PlayVideoModal
        state={open}
        changeState={setOpen}
        title={title}
        overview={overview}
        youtubeUrl={youtubeUrl}
        release={release}
        age={age}
        duration={duration}
        key={id}
      />
    </>
  );
}
