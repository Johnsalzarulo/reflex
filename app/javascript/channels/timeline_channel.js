import CableReady from "cable_ready";
import consumer from "./consumer";

consumer.subscriptions.create("TimelineChannel", {
  received(data) {
    console.log("DATA RECIEVED FORM CABLEREAFY TIMLEINE");

    if (data.cableReady) {
      console.log("SENDING DATA", data);
      CableReady.perform(data.opperations);
    }
  }
});
