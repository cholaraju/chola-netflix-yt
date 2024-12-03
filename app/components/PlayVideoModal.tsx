import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog";
import { Value } from "@prisma/client/runtime/library";

interface iAppProops {
  title: string;
  overview: string;
  youtubeUrl: string;
  state: boolean;
  changeState: (value: boolean) => void;
  release: number;
  age: number;
  duration: number;
}

export default function PlayVideoModal({
  title,
  overview,
  youtubeUrl,
  state,
  changeState,
  release,
  age,
  duration,
}: iAppProops) {
  return (
    <Dialog open={state} onOpenChange={() => changeState(!state)}>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{title}</DialogTitle>
          <DialogDescription className="line-clamp-3">
            {overview}
          </DialogDescription>
          <div className="flex gap-x-2 items-center">
            <p>{release}</p>
            <p className="border py-0.5 px-1 border-gray-200 rounded">{age}+</p>
            <p>{duration}h</p>
          </div>
        </DialogHeader>
        <iframe
          width="100%"
          height="315"
          src={youtubeUrl}
          title="YouTube video player"
          frameBorder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
          allowFullScreen
        ></iframe>
      </DialogContent>
    </Dialog>
  );
}
