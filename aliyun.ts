import { getMoveArgs } from "./src/main";
import getRawBody from 'raw-body';


export function move(req: any, resp: any, context: any) {
    if (req.path != '/move') {
        resp.send(JSON.stringify({}));
    }

    getRawBody(req, async (err: any, body: any) => {
        const event = JSON.parse(body.toString());
        console.log(
            `Generating proof for Move { x1: ${event.x1}, y1:${event.y1}, x2:${event.x2}, y2:${event.y2}, r: ${event.r}, distMax: ${event.distMax} }`
        );

        const moveArgs = await getMoveArgs(event.x1,
            event.y1,
            event.x2,
            event.y2,
            event.r,
            event.distMax
        );
        resp.send(JSON.stringify(moveArgs));
    });
}
