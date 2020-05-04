import CableReady from "cable_ready";
import consumer from "./consumer";

consumer.subscriptions.create("TimelineChannel", {
  received(data) {
    if (data.cableReady) {
      console.log("TimelineChannel recieving cable ready data", data);
      CableReady.perform(data.operations);
    }
  }
});
