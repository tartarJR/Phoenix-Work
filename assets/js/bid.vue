<template>
<div>
<h3>Auction details</h3>
<div class="form-group">
  <label class="control-label col-sm-3">Description:</label>
  <label class="control-label col-sm-9">{{this.item.description}}</label>
</div>
<div class="form-group">
  <label class="control-label col-sm-3">Closing date:</label>
  <label class="control-label col-sm-9">{{this.item.closing_date}}</label>
</div>
<div class="form-group">
  <label class="control-label col-sm-3">Current price:</label>
  <label class="control-label col-sm-9">{{this.item.price}}</label>
</div>
<div class="form-group">
  <input type="text" class="form-control" id="bid" v-model="bid">
  <span class="input-group-btn">
    <button class="btn btn-primary" id="submit_bid" v-on:click="submitBidRequest">Place bid</button>
  </span>
</div>
<router-link :to="{ path: '/'}">Go back</router-link>
<div class="form-group">
  <label class="control-label" id="response">{{response}}</label>
</div>
<table class="table">
    <thead>
      <tr>
        <th>Username</th>
        <th>Date</th>
        <th>Amount</th>
      </tr>
    </thead>
    <tbody id="bids">
        <tr v-for="bid in bids" :key="bid.id">
            <td>{{ bid.user }}</td>
            <td>{{ bid.date }}</td>
            <td>{{ bid.amount }}</td>
        </tr>
    </tbody>
</table>
</div>
</template>

<script>

import axios from "axios";

export default {

    data: function() {
      return {
        item: {
          item_id: "",
          description: "",
          price: 0,
          closing_date: ""
        },
        bid: 0,
        response: "",
        bids: []
      }
    },

    methods: {
      
        submitBidRequest: function() {
            axios.post("/api/items", {bid_amount: this.bid, item_id: this.item.item_id, user_name: "Tatar"})
                    .then(response => {
                        this.response = response.data.msg
                    }).then((response) => {
                        getBids()
                    }).catch(error => {
                        console.log(error);
                    });
        },

        getBids: function() {
            axios.post("/api/bids", {item_id: this.item.item_id})
                    .then(response => {
                        this.bids = response.data.bids
                    }).catch(error => {
                        console.log(error);
                    });
        }

    },

    mounted: function() {
      this.item = this.$route.params;
      getBids()
    }
}

</script>