import Component from "@glimmer/component";
import EmojiValueList from "discourse/admin/components/emoji-value-list";

export default class EmojiList extends Component {
  <template>
    <EmojiValueList
      @setting={{@setting}}
      @values={{@value}}
      @setValidationMessage={{@setValidationMessage}}
      @changeValueCallback={{@changeValueCallback}}
    />
  </template>
}
